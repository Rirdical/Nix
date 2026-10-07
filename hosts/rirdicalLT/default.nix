{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common/base.nix
  ];

  networking.hostName = "rirdicalLT"; # Define your hostname.

  # Fingerprint settings
  services.fwupd.enable = true;
  services.fprintd.enable = true;
  security.pam.services.sudo.fprintAuth = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;
  services.displayManager.plasma-login-manager.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us, ru";
    variant = "";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  hardware.sensor.iio.enable = true;

  # Apps
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  services.happ.enable = true;
  programs.starship.enable = true;
  services.openssh.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [
    bibata-cursors
    steam-run
    lazygit
    nextcloud-client
    fzf
    zoxide
    inputs.zen-browser.packages.${system}.default
    yazi
    wget
    krita
    vivaldi # S Tier Browser
    btop
    git
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    nwg-look
    ghostty
    gnomeExtensions.tweaks-in-system-menu
    gnome-tweaks
    gnome-extension-manager
    fwupd
    libinput
  ];

  system.stateVersion = "26.05";
}
