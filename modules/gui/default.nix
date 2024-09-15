{ config, pkgs, lib, ... }:

{

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
