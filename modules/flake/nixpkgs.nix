{ config, lib, ... }:
let
  byNameDir = ../../nixpkgs/pkgs/by-name;

  packageFiles = lib.concatMapAttrs (
    shard: _:
    lib.mapAttrs (name: _: byNameDir + "/${shard}/${name}/package.nix") (
      builtins.readDir (byNameDir + "/${shard}")
    )
  ) (builtins.readDir byNameDir);
in
{
  flake = {
    overlays.default = final: _prev: lib.mapAttrs (_: file: final.callPackage file { }) packageFiles;

    modules.nixos.nixpkgs-mod = {
      imports = import ../../nixpkgs/nixos/modules/module-list.nix;

      nixpkgs.overlays = [ config.flake.overlays.default ];
    };
  };

  perSystem =
    { pkgs, ... }:
    {
      packages = lib.filterAttrs (_: lib.meta.availableOn pkgs.stdenv.hostPlatform) (
        lib.mapAttrs (_: file: pkgs.callPackage file { }) packageFiles
      );
    };
}
