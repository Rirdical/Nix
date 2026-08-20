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

  imports = [
    ../modules/3Dfetch/fetch.nix
    ../modules/NVF/nvf.nix
    ../modules/Yazi/yazi.nix
  ];

  programs.home-manager.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "ghostty";
  };
}
