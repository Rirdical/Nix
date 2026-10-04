{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home = {
    username = "rirdical";
    homeDirectory = "/home/rirdical";
    stateVersion = "26.05";
  };
  programs.home-manager.enable = true;

  imports = [
    ../modules/3Dfetch/fetch.nix
  ];

  xdg.desktopEntries.nvim-ghostty = {
    # Fix for thunar opening text file inside neovim
    name = "Neovim (Ghostty)";
    exec = "ghostty -e nvim %F";
    terminal = false;
    type = "Application";
    mimeType = ["text/plain"];
    categories = ["Utility" "TextEditor"];
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = "nvim-ghostty.desktop";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "ghostty";
  };
}
