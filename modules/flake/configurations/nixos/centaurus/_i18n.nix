{ pkgs, ... }:
{
  fonts.packages = with pkgs; [ noto-fonts-cjk-sans ];

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [
      "he_IL.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];

    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        ignoreUserConfig = true;
        addons = with pkgs; [
          fcitx5-gtk
          fcitx5-mozc-ut
        ];
        settings = {
          globalOptions = {
            Hotkey = {
              EnumerateWithTriggerKeys = "False";
              EnumerateSkipFirst = "False";
              ModifierOnlyKeyTimeout = "250";
            };
            "Hotkey/EnumerateForwardKeys"."0" = "Alt+Shift_L";
            "Hotkey/EnumerateBackwardKeys"."0" = "Shift+Alt_L";
            "Hotkey/TriggerKeys"."0" = "";
            "Hotkey/AltTriggerKeys"."0" = "";
            "Hotkey/EnumerateGroupForwardKeys"."0" = "";
            "Hotkey/EnumerateGroupBackwardKeys"."0" = "";
            Behavior = {
              ActiveByDefault = "False";
              ShareInputState = "No";
              ShowInputMethodInformation = "False";
            };
          };
          inputMethod = {
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "us";
              DefaultIM = "keyboard-us";
            };
            "Groups/0/Items/0".Name = "keyboard-us";
            "Groups/0/Items/1".Name = "keyboard-il";
            "Groups/1" = {
              Name = "Japanese";
              "Default Layout" = "us";
              DefaultIM = "keyboard-us";
            };
            "Groups/1/Items/0".Name = "keyboard-us";
            "Groups/1/Items/1".Name = "keyboard-il";
            "Groups/1/Items/2".Name = "mozc";
            GroupOrder = {
              "0" = "Default";
              "1" = "Japanese";
            };
          };
        };
      };
    };
  };
}
