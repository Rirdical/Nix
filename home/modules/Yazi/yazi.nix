# Main Yazi configuration — imports all modular pieces
{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # ./settings.nix
    # ./plugins.nix
  ];

  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.default;
    enableZshIntegration = true;
    shellWrapperName = "y";
  };
}
