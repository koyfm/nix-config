{
  flake = {
    modules.homeManager.neovim =
      { lib, pkgs, ... }:
      {
        config = {
          programs.neovim = {
            enable = true;
            extraPackages = with pkgs; [
              gcc
              lua-language-server
              nixd
              nodejs
              ripgrep
              ruff
              stylua
              tree-sitter
              ty
              vscode-langservers-extracted
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

          xdg.configFile."nvim/lua".source = ../../../nvim/lua;
        };
      };
  };
}
