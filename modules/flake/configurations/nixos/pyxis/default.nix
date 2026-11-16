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
            SDL_JOYSTICK_HIDAPI_SWITCH = "0";
          };
          serviceConfig =
            let
              moonlight = pkgs.moonlight-qt.override { ffmpeg = pkgs.rpi.ffmpeg-headless; };
            in
            {
              User = "koi";
              PAMName = "login";
              TTYPath = "/dev/tty1";
              TTYReset = true;
              TTYVHangup = true;
              StandardInput = "tty";
              StandardOutput = "journal";
              ExecStart = "${lib.getExe moonlight}";
              Restart = "always";
              RestartSec = 5;
            };
        };
      };

      services = {
        joycond.enable = true;
        udev.extraRules = ''
          # Ignore partitions with "Required Partition" GPT partition attribute
          ENV{ID_PART_ENTRY_SCHEME}=="gpt", \
            ENV{ID_PART_ENTRY_FLAGS}=="0x1", \
            ENV{UDISKS_IGNORE}="1"
        '';
      };
    };
}
