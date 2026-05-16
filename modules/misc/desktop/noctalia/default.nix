{
  flake = {
    modules.homeManager.noctalia = {
      config = {
        programs.noctalia-shell = {
          enable = true;
        };
      };
    };
  };
}
