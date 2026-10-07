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

  #Stylix
  stylix = {
    enable = true;

    targets = {
      gtk.enable = true;
      qt.enable = true;
    };
  };

  stylix.base16Scheme = {
    base00 = "#070722"; # surface — Default Background
    base01 = "#11112d"; # surface_container — Lighter Background
    base02 = "#17173c"; # surface_container_high — Selection Background
    base03 = "#4e4ec2"; # outline — Comments, Invisibles
    base04 = "#7c80b4"; # on_surface_variant — Dark Foreground
    base05 = "#f3edf7"; # on_surface — Default Foreground
    base06 = "#f3edf7"; # on_surface — Light Foreground
    base07 = "#f3edf7"; # on_background — Lightest Foreground
    base08 = "#fd4663"; # error — Variables, XML Tags, Errors
    base09 = "#9bfece"; # tertiary — Integers, Constants
    base0A = "#a9aefe"; # secondary — Classes, Search Background
    base0B = "#fff59b"; # primary — Strings, Diff Inserted
    base0C = "#81fec1"; # tertiary_fixed_dim — Regex, Escape Chars
    base0D = "#fff280"; # primary_fixed_dim — Functions, Methods
    base0E = "#8188fe"; # secondary_fixed_dim — Keywords, Storage
    base0F = "#910017"; # error_container — Deprecated, Embedded Tags
  };

  # Fingerprint settings
  services.fwupd.enable = true;
  services.fprintd.enable = true;
  security.pam.services.sudo.fprintAuth = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;
  services.displayManager.plasma-login-manager.enable = true;

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
    git = {
      enable = true;
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
