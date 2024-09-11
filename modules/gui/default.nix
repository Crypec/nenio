{ config, pkgs, lib, ... }:

{

  programs.dconf.enable = lib.mkForce true;

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
