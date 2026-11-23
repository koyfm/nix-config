{ config, lib, ... }:
{
  services.sunshine = {
    enable = lib.mkDefault true;
    openFirewall = true;
    capSysAdmin = true;
    settings = {
      capture = "wlr";
      global_prep_cmd =
        let
          niri = lib.getExe config.programs.niri.package;
        in
        builtins.toJSON [
          {
            do = ''sh -c "${
              toString [
                "${niri} msg create-virtual-output"
                "--name sunshine"
                "--width $SUNSHINE_CLIENT_WIDTH"
                "--height $SUNSHINE_CLIENT_HEIGHT"
                "--refresh-rate $SUNSHINE_CLIENT_FPS"
              ]
            }"'';
            undo = "${niri} msg remove-virtual-output sunshine";
          }
          {
            do = "${niri} msg output DP-1 off";
            undo = "${niri} msg output DP-1 on";
          }
        ];
    };
  };

  home-manager.users.koi.programs.niri.settings.outputs."sunshine".scale = 2;
}
