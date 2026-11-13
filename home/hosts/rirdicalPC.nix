{inputs, ...}: {
  home = {
    username = "rirdical";
    homeDirectory = "/home/rirdical";
    stateVersion = "26.05";
  };
  programs.home-manager.enable = true;

  imports = [
    inputs.zen-browser.homeModules.twilight
    ../modules/3Dfetch/fetch.nix
  ];
  stylix = {
    targets = {
      zen-browser = {
        profileNames = ["rirdical"];
        enable = true;
        enableCss = true;
      };
      yazi = {
        enable = true;
        colors.enable = true;
        boldDirectory = true;
      };
      starship.enable = true;
      obsidian.enable = true;
      noctalia.enable = true;
      nixos-icons.enable = true;
      mpv.enable = true;
      lazygit.enable = true;
      ghostty.enable = true;
      fzf.enable = true;
      nixcord.enable = true;
      btop.enable = true;
      bat.enable = true;
      kitty.enable = true;
      nvf = {
        enable = true;
        plugin = "base16";
        transparentBackground = true;
      };
    };
  };
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    profiles = {
      rirdical = {
      };
    };
  };
  programs.yazi.enable = true;

  xdg.desktopEntries.nvim-ghostty = {
    # Fix for thunar opening text file inside neovim
    name = "Neovim (Ghostty)";
    exec = "ghostty -e nvim %F";
    terminal = false;
    type = "Application";
    mimeType = ["text/plain"];
    categories = [
      "Utility"
      "TextEditor"
    ];
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
