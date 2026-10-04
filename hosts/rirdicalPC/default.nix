{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia.nixosModules.default
    ./hardware-configuration.nix
    ../../misc/happ-nixos/happ-module.nix
    ../common/base.nix
    ../modules/Ly/ly.nix
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

  # Set your time zone.
  time.timeZone = "Europe/Samara";

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Internationalisation
  services.xserver.xkb.layout = "us, ru";

  users.users.rirdical = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "audio" "video"]; # Enable ‘sudo’ for the user.
  };
  # Apps
  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };
  services.happ = {
    enable = true;
    forceXwayland = true;
    forceSoftwareRendering = true;
  };
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
  programs.starship.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs.steam.enable = true;
  programs.git = {
    enable = true;
  };
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
    ];
  };
  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.tumbler.enable = true;
  services.flatpak.enable = true;
  services.openssh.enable = true;
  virtualisation.docker.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  programs.gamemode.enable = true;
  security.polkit.enable = true;
  programs.xwayland.enable = true;
  programs.niri.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    wine64Packages.stableFull
    winetricks
    lutris
    herdr
    protontricks
    inputs.zen-browser.packages.${system}.default
    docker-compose
    lazygit
    wget
    vivaldi
    xwayland-satellite
    polkit_gnome
    nextcloud-client
    ghostty
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    mpv
    # rimsort
    kdePackages.ark
    adwaita-icon-theme
    mate-icon-theme
    tango-icon-theme
    papirus-icon-theme
    paper-icon-theme
    nwg-look
    adw-gtk3
    obsidian
    discord
    btop
    gdu
    easyeffects
    ffmpeg
    ffmpegthumbnailer
    ffmpeg-headless
    kdePackages.qtbase
    webp-pixbuf-loader
    swayimg
    nomacs
    bat
    lmstudio
    intiface-central
    unrar
    bluez
    playerctl
    nodejs
    rocmPackages.rocm-smi
    radeontop
    amnezia-vpn
    yazi
    ripdrag # drag.yazi backend
    fd # faster find
    ripgrep # grep
    fzf # fuzzy finder
    zoxide # smarter cd
    file # file type detection
    p7zip # archive preview
    jq # json preview
    localsend
  ];

  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "26.05"; # Did you read the comment?
}
