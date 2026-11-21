{ config, ... }:
let
  nixosModules = with config.flake.modules.nixos; [
    home-manager
    ssh
  ];
  homeManagerModules = with config.flake.modules.homeManager; [
    home-manager
    shell
    zsh
  ];
in
{
  flake.modules.nixos."hosts/aquarius" =
    { pkgs, ... }:
    {
      imports = nixosModules ++ [
        ./_hardware.nix
        ./_disko.nix
      ];

      system.stateVersion = "26.11";

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        zswap.enable = true;
      };

      networking.hostName = "aquarius";

      time.timeZone = "Asia/Jerusalem";

      i18n.defaultLocale = "en_US.UTF-8";

      users.users.koi = {
        isNormalUser = true;
        hashedPassword = "$y$j9T$6wjhqQJnafuweEq181PjS0$i4ellO26Ih.lUEmxkSgnlVa13xxYcNnUqIgdHxUp5n4";
        extraGroups = [ "wheel" ];
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINaEhihITQ0cBCoXKbiHoeRoyAW22l9bIPLn97PLeMwm koi@centaurus"
        ];
      };

      home-manager.users.koi = {
        imports = homeManagerModules;

        home.stateVersion = "26.11";
      };

      services = {
        fwupd.enable = true;
        smartd.enable = true;
      };

      environment = {
        shells = with pkgs; [ zsh ];
        pathsToLink = [ "/share/zsh" ];
      };
    };
}
