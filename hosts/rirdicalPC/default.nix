{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixcord.nixosModules.nixcord
    inputs.noctalia.nixosModules.default
    inputs.juhradial-mx.nixosModules.default
    ./hardware-configuration.nix
    ../common/base.nix
    ../modules/Ly/ly.nix
  ];

  networking.hostName = "rirdicalPC"; # Define your hostname.

  #Stylix
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/eldritch.yaml";
    targets = {
      gtk.enable = true;
      qt.enable = true;
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Apps
  programs.nixcord = {
    enable = true;
    user = "Rirdical";
    discord.vencord.enable = true;
    config.plugins.hideMedia.enable = true;
  };
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
  programs.dconf = {
    enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
  programs.niri.enable = true;
  programs.xwayland.enable = true;
  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.tumbler.enable = true;
  services.flatpak.enable = true;
  services.openssh.enable = true;
  programs.appimage.enable = true;
  virtualisation.docker.enable = true;
  services.xserver.videoDriver = ["amdgpu"];
  services.juhradial-mx.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  programs.gamemode.enable = true;
  security.polkit.enable = true;
  programs.ydotool.enable = true;

  services.open-webui = {
    enable = true;
    host = "127.0.0.1";
    port = 7676;
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    wine64Packages.stableFull
    winetricks
    lutris
    herdr
    protontricks
    # inputs.zen-browser.packages.${system}.default
    docker-compose
    lazygit
    wget
    xwayland-satellite
    polkit_gnome
    nextcloud-client
    ghostty
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    mpv
    # rimsort
    adwaita-icon-theme
    mate-icon-theme
    tango-icon-theme
    papirus-icon-theme
    paper-icon-theme
    nwg-look
    adw-gtk3
    obsidian
    # discord
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
    # yazi
    ripdrag # drag.yazi backend
    fd # faster find
    ripgrep # grep
    fzf # fuzzy finder
    zoxide # smarter cd
    file # file type detection
    jq # json preview
    localsend
    exfatprogs
    usbutils
    wireguard-tools
    xwayland-satellite
    herdr
    telegram-desktop
    vivaldi
    # xarchiver
    p7zip
    unzip
    zip
    kdePackages.ark
    vimhjkl
    kitty
  ];

  system.stateVersion = "26.05"; # Did you read the comment?
}
