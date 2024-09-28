{
  config,
  pkgs,
  lib,
  ...
}: {
  hardware.wooting.enable = true;

  services = {
    dbus.packages = [pkgs.gcr];

    pipewire = {
      enable = true;
      alsa.enable = true;

      # disable 32bit alsa on 64 bit machines
      alsa.support32Bit = false;

      # If you want to use JACK applications, uncomment this
      jack.enable = false;

      pulse.enable = true;
    };
  };

  services.greetd = {
    enable = true;
    settings = rec {
      default_session = {
        command = "sway --unsupported-gpu";
        user = "simon";
      };
    };
  };
}
