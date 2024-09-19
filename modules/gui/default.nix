{ config, pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [
    wooting-udev-rules
  ];

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
