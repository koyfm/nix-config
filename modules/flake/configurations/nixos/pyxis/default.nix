{ config, ... }:
let
  nixosModules = with config.flake.modules.nixos; [
    home-manager
    ssh
  ];
  homeManagerModules = with config.flake.modules.homeManager; [
    home-manager
  ];
in
{
  flake.modules.nixos."hosts/pyxis" =
    { nixos-raspberrypi, ... }:
    {
      imports =
        nixosModules
        ++ (with nixos-raspberrypi.nixosModules; [
          raspberry-pi-5.base
          raspberry-pi-5.page-size-16k
          raspberry-pi-5.display-vc4
        ])
        ++ [ ./_hardware.nix ];

      system.stateVersion = "25.11";

      boot.loader.raspberry-pi.bootloader = "kernel";
      boot.tmp.useTmpfs = true;

      zramSwap.enable = true;

      networking = {
        hostName = "pyxis";
        networkmanager.enable = true;
      };

      time.timeZone = "Asia/Jerusalem";

      i18n.defaultLocale = "en_US.UTF-8";

      users.users.koi = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
      };
      home-manager.users.koi = {
        imports = homeManagerModules;

        home.stateVersion = "25.11";
      };

      services = {
        getty.autologinUser = "koi";
        udev.extraRules = ''
          # Ignore partitions with "Required Partition" GPT partition attribute
          ENV{ID_PART_ENTRY_SCHEME}=="gpt", \
            ENV{ID_PART_ENTRY_FLAGS}=="0x1", \
            ENV{UDISKS_IGNORE}="1"
        '';
      };
    };
}
