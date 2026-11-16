{
  inputs,
  lib,
  ...
}:
{
  flake =
    let
      registry = registryInputs: builtins.mapAttrs (_: flake: { inherit flake; }) registryInputs;
      nixPath = registry: lib.mapAttrsToList (key: value: "${key}=${value.to.path}") registry;
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
        persistent = true;
      };
      settings = {
        flake-registry = "";
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      }
      // (import "${inputs.self}/flake.nix").nixConfig;
      daemonSettings = settings // {
        auto-optimise-store = true;
        trusted-users = [ "@wheel" ];
      };
    in
    {
      modules.nixos.nix =
        { config, ... }:
        {
          nix = {
            registry = registry (removeAttrs inputs [ "nixpkgs" ]); # nixpkgs is registered by lib.nixosSystem
            nixPath = nixPath config.nix.registry;
            inherit gc;
            channel.enable = false;
            settings = daemonSettings;
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
          nix = lib.mkMerge [
            { inherit gc; }
            (lib.mkIf (!(args ? osConfig) || pkgs.stdenv.hostPlatform.isDarwin) {
              package = lib.mkDefault pkgs.nix;
              registry = registry inputs;
              nixPath = nixPath config.nix.registry;
              inherit gc settings;
            })
          ];
        };

      modules.darwin.nix = {
        nix = {
          enable = false;
          channel.enable = false;
          settings = daemonSettings;
        };
      };
    };
}
