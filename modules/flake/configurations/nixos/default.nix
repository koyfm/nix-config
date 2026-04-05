{ config, inputs, ... }:
{
  flake =
    let
      mkSystem =
        system: entrypoint:
        inputs.nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            config.flake.modules.nixos.imports
            entrypoint
          ];
          specialArgs = {
            inherit inputs;
          };
        };
      mkRaspberrypi =
        system: entrypoint:
        inputs.nixos-raspberrypi.lib.nixosSystemFull {
          system = system;
          modules = [
            config.flake.modules.nixos.imports
            entrypoint
          ];
          specialArgs = {
            inherit inputs;
          };
        };
    in
    {
      nixosConfigurations = {
        wsl = mkSystem "x86_64-linux" config.flake.modules.nixos."hosts/wsl";
        centaurus = mkSystem "x86_64-linux" config.flake.modules.nixos."hosts/centaurus";
        cygnus = mkSystem "x86_64-linux" config.flake.modules.nixos."hosts/cygnus";
        pavo = mkSystem "x86_64-linux" config.flake.modules.nixos."hosts/pavo";
        pyxis = mkRaspberrypi "aarch64-linux" config.flake.modules.nixos."hosts/pyxis";
      };
    };

  perSystem = {
    topology.modules = [ { nixosConfigurations = config.flake.nixosConfigurations; } ];
  };
}
