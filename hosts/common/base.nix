{
  config,
  inputs,
  pkgs,
  ...
}: let
  pkgsUnstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };
in {
  imports = [
    ./optimisations.nix
    ./audiofix.nix
  ];

  # -------- basics --------
  time.timeZone = "Europe/Samara";
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

  networking.networkmanager.enable = true;
  # networking.firewall.checkReversePath = false;

  /*
   nixpkgs.overlays = [
     (final: prev: {
       atopile = prev.writeShellScriptBin "atopile" ''
         echo "Atopile placeholder; real package not available on this channel."
       '';
     })
   ];

  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_29;
    daemon.settings = {
      dns = [ "1.1.1.1" "8.8.8.8" ];
      features = {
        buildkit = true;
      };
    };
  };
  */

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["exfat"];

  services.printing.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  # services.gvfs.enable = true;
  # services.udisks2.enable = true;
  # services.hardware.bolt.enable = true;

  users.users.rirdical = {
    isNormalUser = true;
    description = "";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "disk"
    ];
    shell = pkgs.zsh;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.droid-sans-mono
    nerd-fonts.symbols-only
    nerd-fonts.bigblue-terminal
    nerd-fonts.heavy-data
    nerd-fonts.hurmit
    roboto
  ];

  # Program toggles
  programs.xwayland.enable = true;
  programs.niri.enable = true; # Niri session in the display manager

  nixpkgs.config.allowUnfree = true;

  # Graphics (26.05 uses hardware.graphics.*)
  hardware.graphics = {
    enable = true;
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    warn-dirty = false;

    # Only local admins should be able to submit builds to the daemon.
    allowed-users = ["@wheel"];
  };

  environment.systemPackages = with pkgs; [
    exfatprogs
    usbutils
    wireguard-tools
    xwayland-satellite
  ];

  system.stateVersion = "26.05";
}
