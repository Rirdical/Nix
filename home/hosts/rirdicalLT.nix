{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ../modules/3Dfetch/fetch.nix
    ../modules/Yazi/yazi.nix
  ];

  home.username = "rirdical";
  home.homeDirectory = "/home/rirdical";
  home.stateVersion = "26.05"; # match your system's initial version
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "ghostty";
  };
}
