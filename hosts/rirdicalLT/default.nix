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

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "rirdicalLT"; # Define your hostname.
  # Enable networking
  networking.networkmanager.enable = true;
  # Fingerprint settings
  services.fwupd.enable = true;
  services.fprintd.enable = true;
  services.desktopManager.gnome.sessionPath = [pkgs.gdm];
  security.pam.services.sudo.fprintAuth = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  # Set your time zone.
  time.timeZone = "Europe/Samara";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us, ru";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  hardware.sensor.iio.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
  users.defaultUserShell = pkgs.zsh;
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
    libinput-utils
  ];

  services.openssh.enable = true;

  # networking.firewall.enable = false;

  system.stateVersion = "26.05";
}
