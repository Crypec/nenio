{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.simon = {
    isNormalUser = true;
    description = "Simon";

    shell = pkgs.nushell;

    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "audio"
      "input"
    ];

    packages = with pkgs; [
      eza
    ];
  };

  # Home-manager configuration
  home-manager.users.simon = {pkgs, ...}: {
    home = {
      username = "simon";
      homeDirectory = "/home/simon";
      sessionVariables = rec {
        EDITOR = "hx";
        GIT_EDITOR = EDITOR;
      };
      packages = with pkgs; [];
    };

    # Import the home-manager configuration
    imports = [../home];

    accounts.email.accounts = {
      systemli = rec {
        address = "simon.kunz@systemli.org";
        realName = "Simon Kunz";
        primary = true;


        mbsync.enable = true;
        notmuch.neomutt.enable = true;
        notmuch.enable = true;
        neomutt.enable = false;

        userName = "${address}";
        imap.host = "mail.systemli.org";
        passwordCommand = "rbw get ${address}";
      };
    };
  };


  nix.settings.trusted-users = ["simon"];
}
