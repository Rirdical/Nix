{ pkgs, inputs, ... }:

{
  programs.yazi = {
    enable = true;
    
    # Force bleeding-edge package from upstream flake
    package = inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.default;
    
    # Shell wrapper so `y` launches yazi and cd's on quit
    enableZshIntegration = true;  # or enableBashIntegration
    shellWrapperName = "y";
  };

  home.packages = with pkgs; [
    ripdrag  # Required for drag-and-drop plugin
  ];
}
