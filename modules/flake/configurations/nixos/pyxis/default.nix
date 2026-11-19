{ config, ... }:
let
  nixosModules = with config.flake.modules.nixos; [
    home-manager
    ssh
    audio
  ];
  homeManagerModules = with config.flake.modules.homeManager; [
    home-manager
  ];
in
{
  flake.modules.nixos."hosts/pyxis" =
    {
      lib,
      nixos-raspberrypi,
      pkgs,
      ...
    }:
    {
      imports =
        nixosModules
        ++ (with nixos-raspberrypi.nixosModules; [
          raspberry-pi-5.base
          # raspberry-pi-5.page-size-16k
          raspberry-pi-5.display-vc4
        ])
        ++ [ ./_hardware.nix ];

      system.stateVersion = "25.11";

      nixpkgs.overlays = [
        (final: prev: {
          moonlight-qt = prev.moonlight-qt.override {
            ffmpeg = final.rpi.ffmpeg-headless;
            SDL2 = final.sdl2-compat.override {
              # https://github.com/moonlight-stream/moonlight-qt/issues/2104
              sdl3 = final.sdl3.overrideAttrs (old: {
                patches = (old.patches or [ ]) ++ [ ./sdl3-hidapi-udev-filter.patch ];
                doCheck = false; # test fails in qemu
              });
            };
          };
        })
      ];

      boot.loader.raspberry-pi.bootloader = "kernel";
      boot.tmp.useTmpfs = true;

      zramSwap.enable = true;

      networking = {
        hostName = "pyxis";
        networkmanager.enable = true;
      };

      time.timeZone = "Asia/Jerusalem";

      i18n.defaultLocale = "en_US.UTF-8";

      hardware = {
        graphics.enable = true;
        bluetooth.enable = true;
        steam-hardware.enable = true;
      };

      users.users.koi = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "video"
          "render"
          "input"
          "audio"
        ];
      };
      home-manager.users.koi = {
        imports = homeManagerModules;

        home.stateVersion = "25.11";
      };

      systemd = {
        defaultUnit = "graphical.target";

        services.moonlight = {
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
      };

      services = {
        udev.extraRules = ''
          # Ignore partitions with "Required Partition" GPT partition attribute
          ENV{ID_PART_ENTRY_SCHEME}=="gpt", \
            ENV{ID_PART_ENTRY_FLAGS}=="0x1", \
            ENV{UDISKS_IGNORE}="1"
        '';
      };
    };
}
