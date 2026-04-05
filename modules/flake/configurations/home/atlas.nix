{ config, ... }:
{
  flake.modules.homeManager."hosts/atlas" = {
    imports = with config.flake.modules.homeManager; [
      dev
    ];
    home.stateVersion = "23.11";
    home.username = builtins.getEnv "USER";
    home.homeDirectory = builtins.getEnv "HOME";
  };
}
