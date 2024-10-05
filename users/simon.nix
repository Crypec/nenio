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
  home-manager.users.simon = {
    pkgs,
    config,
    ...
  }: {
    home = {
      username = "simon";
      homeDirectory = "/home/simon";
      sessionVariables = rec {
        EDITOR = "hx";
        GIT_EDITOR = EDITOR;
      };
      packages = with pkgs; [];
    };

    accounts = {
      calendar = {
        basePath = "${config.home.homeDirectory}/.local/share/calendars";
        accounts.primary = {
          primary = true;
          remote = {
            type = "caldav";
            url = "https://baikal.ctx.dev/dav.php/";
            userName = "simon@ctx.dev";
            passwordCommand = ["rbw get baikal.ctx.dev" ];
          };
          vdirsyncer.enable = true;
          qcal.enable = true;
          khal.enable = true;
        };
      };
      email = {
        maildirBasePath = "${config.home.homeDirectory}/.local/share/mail/";
        accounts = {
          systemli = rec {
            address = "simon.kunz@systemli.org";
            realName = "Simon Kunz";

            primary = true;

            userName = "simon.kunz@systemli.org";

            imap.host = "mail.systemli.org";
            smtp.host = "mail.systemli.org";

            notmuch.enable = true;
            mbsync = {
              enable = true;
              create = "maildir";
            };

            neomutt.enable = true;

            passwordCommand = "rbw get ${address}";
          };
        };
      };
    };

    # Import the home-manager configuration
    imports = [../home];
  };

  nix.settings.trusted-users = ["simon"];
}
