{ lib, pkgs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      moonlight-qt = prev.moonlight-qt.override {
        ffmpeg = final.rpi.ffmpeg-headless;
        SDL2 = final.sdl2-compat.override {
          # https://github.com/moonlight-stream/moonlight-qt/issues/2104
          sdl3 = final.sdl3.overrideAttrs (old: rec {
            version = "3.4.20";
            src = old.src.override {
              tag = "release-${version}";
              hash = "sha256-4BzkSQg2LkfMw0+Q66sKncA1vF7td7ulYN8MExWPfls=";
            };
            doCheck = false; # test fails in qemu
          });
        };
      };
    })
  ];

  systemd.services.moonlight = {
    wantedBy = [ "graphical.target" ];
    after = [
      "systemd-user-sessions.service"
      "network-online.target"
    ];
    wants = [ "network-online.target" ];
    conflicts = [ "getty@tty1.service" ];
    environment = {
      QT_SCALE_FACTOR = "1.28";
      QT_QPA_EGLFS_KMS_CONFIG = toString (
        pkgs.writeText "eglfs-kms.json" (
          builtins.toJSON { device = "/dev/dri/by-path/platform-axi:gpu-card"; }
        )
      );
    };
    serviceConfig = {
      User = "koi";
      PAMName = "login";
      TTYPath = "/dev/tty1";
      TTYReset = true;
      TTYVHangup = true;
      StandardInput = "tty";
      StandardOutput = "journal";
      ExecStart = lib.getExe pkgs.moonlight-qt;
      Restart = "always";
      RestartSec = 5;
    };
  };
}
