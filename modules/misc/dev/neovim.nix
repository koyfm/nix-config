{ inputs, ... }:
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
            initLua = lib.mkMerge [
              (lib.mkBefore ''
                disableMason = true
              '')
              (builtins.readFile "${inputs.nvim-config}/init.lua")
            ];
          };

          xdg.configFile."nvim/lua".source = "${inputs.nvim-config}/lua";
        };
      };
  };
}
