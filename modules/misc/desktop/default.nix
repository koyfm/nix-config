{
  flake = {
    modules.nixos.desktop = {
      config = {
        environment.sessionVariables.NIXOS_OZONE_WL = "1";

        services.earlyoom.enable = true;

        programs = {
          localsend = {
            enable = true;
            openFirewall = true;
          };
        };
      };
    };
    modules.homeManager.desktop =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        config = {
          home = {
            preferXdgDirectories = true;

            packages = with pkgs; [
              android-tools
              bitwarden-desktop
              libreoffice
              notes
              btop
              nvtopPackages.full
              thunderbird
              onlyoffice-desktopeditors
              qbittorrent
              scrcpy
              telegram-desktop
              wl-clipboard
              pinta
            ];
          };

          xdg = {
            autostart = {
              enable = true;
              readOnly = true;
              entries = [
                "${config.programs.discord.package}/share/applications/discord.desktop"
                "${config.programs.firefox.package}/share/applications/firefox.desktop"
                "${config.programs.obsidian.package}/share/applications/obsidian.desktop"
              ];
            };
            mimeApps = {
              enable = true;
              defaultApplicationPackages = with pkgs; [
                firefox
                thunderbird
              ];
            };
          };

          programs = {
            discord = {
              enable = true;
              package = (pkgs.discord.override { withVencord = true; });
              settings.DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING = true;
            };
            firefox = {
              enable = true;
              profiles = {
                default = {
                  settings = {
                    "browser.urlbar.showSearchSuggestionsFirst" = false;

                    # https://bugzilla.mozilla.org/show_bug.cgi?id=1732114
                    "privacy.resistFingerprinting" = false;
                    "privacy.fingerprintingProtection" = true;
                    "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme";

                    "sidebar.revamp" = true;
                    "sidebar.revamp.round-content-area" = true;
                    "sidebar.verticalTabs" = true;
                    "sidebar.visibility" = "expand-on-hover";
                    "signon.rememberSignons" = false;
                    "ui.key.menuAccessKeyFocuses" = false;
                  };
                };
              };
            };
            obsidian.enable = true;
            java.enable = true;
            mpv = {
              enable = true;
              scriptOpts = {
                ytdl_hook = {
                  ytdl_path = "${lib.getExe config.programs.yt-dlp.package}";
                };
              };
            };
            yazi.enable = true;
            yt-dlp.enable = true;
          };
          catppuccin.yazi.enable = true;
        };
      };
    modules.darwin.desktop = {
      config = {
        homebrew.casks = [
          "anki"
          "bitwarden"
          "claude"
          "discord"
          "karabiner-elements"
          "ollama-app"
          "telegram"
          "vladdoster/formulae/vimari"
          "whatsapp"
        ];

        system = {
          defaults = {
            controlcenter = {
              BatteryShowPercentage = true;
            };
            NSGlobalDomain = {
              NSWindowShouldDragOnGesture = true;
            };
          };
        };
      };
    };
  };
}
