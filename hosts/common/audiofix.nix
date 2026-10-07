{pkgs, ...}: {
  services.pulseaudio.enable = false; # disable pipewire
  security.rtkit.enable = true; # high priority for audio

  services.pipewire = {
    # enable pipewire
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;

    wireplumber.extraConfig."99-keep-alsa-devices-awake" = {
      # no stutter with audio
      "monitor.alsa.rules" = [
        {
          matches = [
            {"node.name" = "~alsa_input.*";}
          ];
          actions.update-props = {
            "session.suspend-timeout-seconds" = 0;
          };
        }
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    # installs pipewire and pulseaudio
    pipewire
    wireplumber
  ];
}
