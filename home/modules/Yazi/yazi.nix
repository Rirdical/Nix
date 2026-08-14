# Main Yazi configuration — imports all modular pieces
{ pkgs, inputs, ... }:

{
  imports = [
    ./yazi/settings.nix
    ./yazi/keymap.nix
    ./yazi/theme.nix
    ./yazi/plugins.nix
  ];

  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.default;
    enableZshIntegration = true;
    shellWrapperName = "y";
  };

  # Dependencies used by plugins and yazi itself
  home.packages = with pkgs; [
    ripdrag      # drag.yazi backend
    fd           # faster find
    ripgrep      # grep
    fzf          # fuzzy finder
    zoxide       # smarter cd
    file         # file type detection
    p7zip        # archive preview
    jq           # json preview
  ];
}
