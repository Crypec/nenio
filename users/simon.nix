{
  config,
  pkgs,
  lib,
  sops,
  ...
}: {

  imports = [
    ../secrets
  ];

  sops.secrets.simon-password = {};
  users.users.simon = {
    isNormalUser = true;
    description = "Simon";

    # shell = pkgs.zsh;

    extraGroups = [
      "wheel"
      "audio"
      (lib.mkIf config.networking.networkmanager.enable "networkmanager")
      (lib.mkIf config.hardware.wooting.enable "input")
      (lib.mkIf config.virtualisation.docker.enable "docker")
      (lib.mkIf config.virtualisation.libvirtd.enable "libvirtd")
    ];

    openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIAS9of3GJjjn5xCnutXEKdBhSd0EPakre7ZcTDMgGOHUAAAABHNzaDo= simon@date"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOIazPvidQMTZIUO7YIZXqsKBxABrBkK11/R9nHRo/1z simon@date"
    ];

    hashedPasswordFile = sops.secrets.simon-password.path;

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
            passwordCommand = ["rbw get baikal.ctx.dev"];
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
            passwordCommand = "rbw get ${address}";

            imap.host = "mail.systemli.org";
            smtp.host = "mail.systemli.org";

            notmuch.enable = true;
            mbsync = {
              enable = true;
              create = "maildir";
            };
            neomutt.enable = true;

            gpg = {
              encryptByDefault = true;
              signByDefault = true;
            };
          };
        };
      };
      contact = {
        accounts.primary = {
          remote = {
            type = "carddav";
            url = "https://baikal.ctx.dev";
            userName = "simon@ctx.dev";
            passwordCommand = "rbw get baikal.ctx.dev";
          };
        };
      };
    };

    # Import the home-manager configuration
    imports = [../home];
  };

  nix.settings.trusted-users = ["simon"];
}
