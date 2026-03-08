{
  flake = {
    modules.homeManager.neovim =
      { lib, pkgs, ... }:
      {
        config = {
          programs.neovim = {
            enable = true;
            extraPackages = with pkgs; [
              nodejs
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
              '')
              (builtins.readFile ../../../nvim/init.lua)
            ];
          };

          xdg.configFile."nvim/parser".source =
            let
              parsers = pkgs.symlinkJoin {
                name = "treesitter-parsers";
                paths =
                  (pkgs.vimPlugins.nvim-treesitter.withPlugins (
                    plugins: with plugins; [
                      c
                      json
                      lua
                      python
                      typescript
                      yaml
                    ]
                  )).dependencies;
              };
            in
            "${parsers}/parser";

          xdg.configFile."nvim/lua".source = ../../../nvim/lua;
        };
      };
  };
}
