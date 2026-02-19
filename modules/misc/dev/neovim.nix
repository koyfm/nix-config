{
  flake = {
    modules.homeManager.neovim =
      { lib, pkgs, ... }:
      {
        config = {
          programs.neovim = {
            enable = true;
            extraPackages = with pkgs; [
              lua-language-server
              ripgrep
              ruff
              stylua
              tree-sitter
              ty
            ];
            plugins = with pkgs.vimPlugins; [ lazy-nvim ];
            initLua = lib.mkMerge [
              (lib.mkBefore ''
                telescopeNativeFzf = true
                disableMason = true
                clearTreesitterDependencies = false
              '')
              (builtins.readFile ../../../nvim/init.lua)
            ];
          };

          xdg.configFile."nvim/lua".source = ../../../nvim/lua;
        };
      };
  };
}
