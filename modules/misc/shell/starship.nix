{
  flake = {
    modules.homeManager.starship = {
      config = {
        programs.starship = {
          enable = true;
          settings = {
            add_newline = false;
            format = "$directory$git_branch$fill$all$time$line_break$character";
            fill.symbol = " ";
            status.disabled = false;
            time = {
              disabled = false;
              use_12hr = true;
            };
            gcloud.detect_env_vars = [ "CLOUDSDK_ACTIVE_CONFIG_NAME" ];
          };
        };
        catppuccin.starship.enable = true;
      };
    };
  };
}
