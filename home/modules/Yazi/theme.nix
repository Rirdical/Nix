# theme.toml equivalent — colors, flavors, icons
{ pkgs, ... }:

{
  programs.yazi = {
    flavors = {
      inherit (pkgs.yaziPlugins)
        kanagawa
        catppuccin-mocha
        catppuccin-latte
        tokyo-night
        nord
        dracula;
    };

    theme = {
      flavor = {
        dark = "kanagawa";
        light = "catppuccin-latte";
      };

      icon.rules = [
        { name = "*.nix"; text = ""; fg = "#7ebae4"; }
        { name = "*.rs"; text = ""; fg = "#dea584"; }
        { name = "*.toml"; text = ""; fg = "#9c9c9c"; }
        { name = "*.md"; text = ""; fg = "#ffffff"; }
        { name = "*.lua"; text = ""; fg = "#51a0cf"; }
        { name = "*.py"; text = ""; fg = "#ffbc03"; }
        { name = "*.js"; text = ""; fg = "#f7df1e"; }
        { name = "*.ts"; text = ""; fg = "#3178c6"; }
        { name = "*.html"; text = ""; fg = "#e34c26"; }
        { name = "*.css"; text = ""; fg = "#563d7c"; }
        { name = "*.json"; text = ""; fg = "#cbcb41"; }
        { name = "*.yaml"; text = ""; fg = "#cb171e"; }
        { name = "*.sh"; text = ""; fg = "#4d5a5e"; }
        { name = "*.zip"; text = ""; fg = "#f9e2af"; }
        { name = "*.tar*"; text = ""; fg = "#f9e2af"; }
        { name = "flake.lock"; text = ""; fg = "#7ebae4"; }
        { name = "Makefile"; text = ""; fg = "#f9e2af"; }
        { name = ".gitignore"; text = ""; fg = "#f54d27"; }
        { name = ".git"; text = ""; fg = "#f54d27"; }
        { name = "node_modules"; text = ""; fg = "#5fa04e"; }
        { name = "target"; text = ""; fg = "#dea584"; }
      ];

      filetype.rules = [
        { mime = "image/*"; fg = "#a6e3a1"; }
        { mime = "video/*"; fg = "#f9e2af"; }
        { mime = "audio/*"; fg = "#cba6f7"; }
        { mime = "application/zip"; fg = "#f9e2af"; }
        { mime = "application/gzip"; fg = "#f9e2af"; }
        { mime = "application/x-tar"; fg = "#f9e2af"; }
        { mime = "application/pdf"; fg = "#f38ba8"; }
        { mime = "text/*"; fg = "#cdd6f4"; }
      ];

      status = {
        separator_open = "";
        separator_close = "";
      };
    };
  };
}
