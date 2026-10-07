{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./optimisations.nix
    ./audiofix.nix
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };
  boot.supportedFilesystems = ["exfat"];

  time.timeZone = "Europe/Samara";
  services.xserver.xkb.layout = "us, ru";
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

  services.printing.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

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

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };
}
