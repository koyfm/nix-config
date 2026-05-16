{
  flake = {
    modules.homeManager.noctalia =
      { config, lib, ... }:
      {
        config = {
          programs.noctalia-shell = {
            enable = true;
          };

          programs.niri.settings = {
            spawn-at-startup = [
              { command = [ "noctalia-shell" ]; }
            ];
            binds =
              let
                noctalia-shell = lib.getExe config.programs.noctalia-shell.package;
                ipc = args: {
                  action.spawn = [
                    noctalia-shell
                    "ipc"
                    "call"
                  ]
                  ++ args;
                  hotkey-overlay.hidden = true;
                };
              in
              {
                "Mod+Space" = ipc [
                  "launcher"
                  "toggle"
                ];
                "Mod+S" = ipc [
                  "controlCenter"
                  "toggle"
                ];
                "Mod+Comma" = ipc [
                  "settings"
                  "toggle"
                ];

                "Super+Alt+L" = ipc [
                  "lockScreen"
                  "lock"
                ];

                "XF86AudioRaiseVolume" = ipc [
                  "volume"
                  "increase"
                ];
                "XF86AudioLowerVolume" = ipc [
                  "volume"
                  "decrease"
                ];
                "XF86AudioMute" = ipc [
                  "volume"
                  "muteOutput"
                ];
                "XF86AudioMicMute" = ipc [
                  "volume"
                  "muteInput"
                ];

                "XF86AudioPlay" = ipc [
                  "media"
                  "playPause"
                ];
                "XF86AudioStop" = ipc [
                  "media"
                  "pause"
                ];
                "XF86AudioPrev" = ipc [
                  "media"
                  "previous"
                ];
                "XF86AudioNext" = ipc [
                  "media"
                  "next"
                ];

                "XF86MonBrightnessUp" = ipc [
                  "brightness"
                  "increase"
                ];
                "XF86MonBrightnessDown" = ipc [
                  "brightness"
                  "decrease"
                ];
              };
          };
        };
      };
  };
}
