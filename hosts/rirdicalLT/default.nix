{ config, pkgs, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../misc/happ-nixos/happ-module.nix
      ../common/base.nix
    ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "rirdicalLT"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Fingerprint settings
  services.fwupd.enable = true;
  services.fprintd.enable = true;
  services.desktopManager.gnome.sessionPath = [ pkgs.gdm ];
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

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  hardware.sensor.iio.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Apps
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
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
    lazygit
    nextcloud-client
    fzf
    zoxide
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
  ];


  services.openssh.enable = true;

  # networking.firewall.enable = false;

  system.stateVersion = "26.05"; 

}
