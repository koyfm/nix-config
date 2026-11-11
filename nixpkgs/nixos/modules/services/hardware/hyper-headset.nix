{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.hyper-headset;
in
{
  options.services.hyper-headset = {
    enable = lib.mkEnableOption "HyperHeadset, a CLI and tray application for HyperX headsets";

    package = lib.mkPackageOption pkgs "hyper-headset" { };

    autostart = lib.mkEnableOption "starting the HyperHeadset tray application with the graphical session";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    services.udev.packages = [ cfg.package ];

    systemd.user.services.hyper-headset = lib.mkIf cfg.autostart {
      description = "HyperHeadset tray application";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = lib.getExe cfg.package;
        Restart = "on-failure";
        RestartSec = 5;
      };
    };
  };

  meta.maintainers = [ ];
}
