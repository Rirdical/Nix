{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.username = "rirdical";
  home.homeDirectory = "/home/rirdical";
  home.stateVersion = "26.05"; # match your system's initial version

  imports = [
    ../modules/3Dfetch/fetch.nix
    ../modules/NVF/nvf.nix
  ];

  home.packages = with pkgs; [htop git];
  programs.git.enable = true;
  programs.home-manager.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "ghostty";
  };
}
