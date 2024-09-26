{ config, pkgs, lib, ... }:

{

  hardware.wooting.enable = true;

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
