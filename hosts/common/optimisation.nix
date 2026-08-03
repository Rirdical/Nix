{ config, ... }:
{
  # Keep common values as the source of truth for all hosts.
  # This flake lives in /home/luix and /etc/nixos is a symlink to it. The
  # root-owned auto-upgrade service cannot safely fetch that local Git repo, so
  # keep upgrades explicit through buildall/flakeonly instead.
  system.autoUpgrade = { 				# have a script to do upgrade manually
    enable = false; 
    allowReboot = false;
    flake = "/etc/nixos#${config.networking.hostName}";
    dates = "daily";
  };

  nix.gc = {					 	# Garbage collector
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 20d";
  };

  nix.optimise = { 					# Nix optimization
    automatic = true;
    dates = [ "weekly" ];
  };
  
  nix.settings.auto-optimise-store = true;		# Nix store optimization

  # Keep boot entry limit aligned across bootloaders.
  boot.loader.grub.configurationLimit = 10;
  boot.loader.systemd-boot.configurationLimit = 10;

  services.fwupd.enable = true; 			# auto drivers and firmware for peripherals
  services.fstrim.enable = true;			# Good for SSD health

  hardware.bluetooth = {				# enable bluetooth and enable fastconnection
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
  # services.blueman.enable = true;			# install and enable blueman

}
