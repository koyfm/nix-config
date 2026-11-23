{ lib, pkgs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      niri = prev.niri.overrideAttrs {
        src = final.fetchFromGitHub {
          owner = "willybarret";
          repo = "niri";
          rev = "7fd585dd44ed67644977dd9561bb6e8b3837f8f7";
          hash = "sha256-OWF03QF62Q8HJ3fCme3I3GX7dKX9YU+JD7bhTiIzfQ4=";
        };
        cargoDeps = final.rustPlatform.fetchCargoVendor {
          inherit (final.niri) src;
          hash = "sha256-Yqvambc4F7PdGkGxrxp5xD6PqAEAWmMgqOYZRY+TIBA=";
        };
      };
    })
  ];

  home-manager.users.koi.programs.niri.settings = {
    input = {
      mouse = {
        accel-speed = 0.5;
      };
      keyboard.xkb = {
        layout = lib.mkForce "us";
        options = lib.mkForce "";
      };
    };
    outputs."DP-1" = {
      mode = {
        width = 3440;
        height = 1440;
        refresh = 164.900;
      };
      variable-refresh-rate = "on-demand";
    };
    binds."Mod+Shift+Space" = {
      action.spawn = [
        (lib.getExe' pkgs.fcitx5 "fcitx5-remote")
        "-t"
      ];
      hotkey-overlay.title = "Toggle input method";
    };
  };
}
