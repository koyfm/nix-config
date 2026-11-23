{ config, ... }:
let
  nixosModules = with config.flake.modules.nixos; [
    audio
    desktop
    dev
    gaming
    gnome
    home-manager
    niri
    sops
    ssh
    wireguard
  ];
  homeManagerModules = with config.flake.modules.homeManager; [
    audio
    desktop
    dev
    gaming
    ghostty
    gnome
    home-manager
    niri
    noctalia
    shell
    sops
    starship
    theme
    tmux
    zsh
  ];
in
{
  flake.modules.nixos."hosts/centaurus" =
    { config, pkgs, ... }:
    {
      imports = nixosModules ++ [
        ./_hardware.nix
        ./_i18n.nix
        ./_ai.nix
        ./_niri.nix
        ./_sunshine.nix
      ];

      nixpkgs.overlays = [
        (_: prev: {
          # TODO https://github.com/pwr-Solaar/Solaar/issues/3372
          solaar = prev.solaar.overrideAttrs (old: {
            postPatch = (old.postPatch or "") + ''
              substituteInPlace lib/logitech_receiver/settings_templates.py \
                --replace-fail 'common.NamedInts(LOW=0, MEDIUM=1, HIGH=2)' \
                              'common.NamedInts(LOW=1, MEDIUM=2, HIGH=3)'
              substituteInPlace tests/logitech_receiver/test_setting_templates.py \
                --replace-fail 'common.NamedInts(LOW=0, MEDIUM=1, HIGH=2)' \
                              'common.NamedInts(LOW=1, MEDIUM=2, HIGH=3)'
            '';
          });
        })
      ];

      system.stateVersion = "25.05";

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        binfmt.emulatedSystems = [ "aarch64-linux" ];
        zswap.enable = true;
      };

      sops.secrets."koi-password".neededForUsers = true;

      networking = {
        hostName = "centaurus";
        networkmanager.enable = true;
      };

      time.timeZone = "Asia/Jerusalem";

      users.users.koi = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets."koi-password".path;
        extraGroups = [
          "wheel"
          "docker"
          "dialout"
          "gamemode"
          "openrazer"
        ];
        shell = pkgs.zsh;
      };
      home-manager.users.koi =
        { pkgs, ... }:
        {
          imports = homeManagerModules;

          home.stateVersion = "26.05";
          home.packages = with pkgs; [ prismlauncher ];

          dconf.settings."org/gnome/shell".enabled-extensions = [ "hass-gshell@geoph9-on-github" ];
        };

      services = {
        printing.enable = true;
        flatpak.enable = true;
        fwupd.enable = true;
        smartd.enable = true;
        hardware.openrgb.enable = true;
        hyper-headset = {
          enable = true;
          autostart = true;
        };
        tailscale.enable = true;
      };

      programs.solaar = {
        enable = true;
        userService.enable = true;
      };

      environment = {
        shells = with pkgs; [ zsh ];
        pathsToLink = [ "/share/zsh" ];
        systemPackages = with pkgs; [
          openrazer-daemon
          polychromatic
        ];
      };

      security.rtkit.enable = true;
    };
}
