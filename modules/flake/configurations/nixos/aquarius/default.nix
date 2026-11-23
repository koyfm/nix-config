{ config, ... }:
let
  nixosModules = with config.flake.modules.nixos; [
    home-manager
    sops
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
    { config, pkgs, ... }:
    {
      imports = nixosModules ++ [
        ./_hardware.nix
        ./_disko.nix
        ./_samba.nix
      ];

      system.stateVersion = "26.11";

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        zswap.enable = true;
        initrd = {
          network = {
            enable = true;
            ssh = {
              enable = true;
              port = 2222;
              hostKeys = [ "/etc/secrets/initrd/ssh_host_ed25519_key" ];
              authorizedKeys = [
                ''command="systemctl default" ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINaEhihITQ0cBCoXKbiHoeRoyAW22l9bIPLn97PLeMwm koi@centaurus''
              ];
            };
          };
          clevisLuksAskpass = {
            enable = true;
            # TODO https://github.com/NixOS/nixpkgs/pull/587954
            package = pkgs.clevis.override { systemd = config.boot.initrd.systemd.package; };
          };
        };
      };

      networking.hostName = "aquarius";

      time.timeZone = "Asia/Jerusalem";

      i18n.defaultLocale = "en_US.UTF-8";

      sops.secrets."koi-passwd".neededForUsers = true;

      users.users.koi = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets."koi-passwd".path;
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
        systemPackages = with pkgs; [ clevis ];
      };
    };
}
