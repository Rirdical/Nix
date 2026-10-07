{config, ...}: {
  nix.gc = {
    # Garbage collector
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };

  nix.optimise = {
    automatic = true;
    dates = ["weekly"];
  };

  nix.settings.auto-optimise-store = true; # Nix store optimization

  # Keep boot entry limit aligned across bootloaders.
  boot.loader.systemd-boot.configurationLimit = 10;

  services.fwupd.enable = true; # auto drivers and firmware for peripherals
  services.fstrim.enable = true; # Good for SSD health

  hardware.bluetooth = {
    # enable bluetooth and enable fastconnection
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        FastConnectable = "true";
        Experimental = "true";
      };
      Policy = {
        AutoEnable = "true";
      };
    };
  };
}
