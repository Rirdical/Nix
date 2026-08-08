{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.noctalia.nixosModules.default
    ../../misc/happ-nixos/happ-module.nix
    ../common/base.nix
  ];

  # Bootloader configuration and kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.nameservers = ["94.140.14.14" "9.9.9.9"]; # AdGuard and Quad9
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  networking.networkmanager.unmanaged = ["tun0"];
  networking.hostName = "rirdicalPC"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = false;
    trustedInterfaces = ["tun0"];
  };

  #
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/rirdical/.nix/";
  };
  # Set your time zone.
  time.timeZone = "Europe/Samara";

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Internationalisation
  services.xserver.xkb.layout = "us, ru";

  # User account definition
  # home.username = "rirdical";
  # home.homeDirectory = "/home/rirdical";
  users.users.rirdical = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "audio" "video"]; # Enable ‘sudo’ for the user.
  };

  # Apps
  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };
  services.happ.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.starship.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs.steam.enable = true;

  # System-wide packages
  environment.systemPackages = with pkgs; [
    lazygit
    wget
    git
    firefox
    vivaldi
    xwayland-satellite
    webcord
    amnezia-vpn
    polkit_gnome
    webcord
    nextcloud-client
    ghostty
    kdePackages.dolphin
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    fzf
    zoxide
    gnome-icon-theme
    adwaita-icon-theme
    mate-icon-theme
    gnome-icon-theme
    tango-icon-theme
    papirus-icon-theme
    paper-icon-theme
    kdePackages.kio
    kdePackages.kio-extras
    geeqie
    mpv
    rimsort
    kdePackages.ark
    nwg-look
    adw-gtk3
    obsidian
    discord
    btop
    gdu
    eog
    fzf
    zoxide
  ];

  # Fix for Dolphin open with
  xdg.menus.enable = true;
  xdg.mime.enable = true;
  environment.etc."/xdg/menus/applications.menu".text =
    builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };
  security.polkit.enable = true;

  programs.xwayland.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.niri.enable = true;
  programs.yazi.enable = true;

  services.displayManager.ly.enable = true;

  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # home-manager = {
  #  extraSpecialArgs = { inherit inputs; };
  #  users = {
  #   "rirdical" = import ./home.nix;
  #  };
  # };

  system.stateVersion = "26.05"; # Did you read the comment?
}
