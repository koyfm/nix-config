{
  inputs,
  lib,
  ...
}:
{
  flake =
    let
      nixConfig = registry: {
        registry = builtins.mapAttrs (_: flake: { inherit flake; }) inputs;
        nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") registry;
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 30d";
          persistent = true;
        };
      };
      nixSettings = {
        flake-registry = "";
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    in
    {
      modules.nixos.nix =
        { config, ... }:
        {
          nix = nixConfig config.nix.registry // {
            channel.enable = false;
            settings = nixSettings;
          };
        };

      modules.homeManager.nix =
        {
          config,
          lib,
          pkgs,
          ...
        }@args:
        {
          nix = nixConfig config.nix.registry // {
            package = lib.mkDefault pkgs.nix;
            settings = lib.mkIf (!builtins.hasAttr "osConfig" args) nixSettings;
          };
        };

      modules.darwin.nix = {
        nix = {
          enable = false;
          channel.enable = false;
        };
      };
    };
}
