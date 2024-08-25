{ config, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = rec {
      theme = "border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red";
      session_cmd = "sway --unsupported-gpu";
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --theme '${theme}' --cmd '${session_cmd}'";
        user = "simon";
      };
    };
  };
}
