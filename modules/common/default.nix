{
  pkgs,
  lib,
  inputs,
  alejandra,
  ...
}: {
  imports = [
    ../../users/root.nix

    ../../secrets
  ];

  # TODO(Simon): either learn how to use it or get rid of it
  # programs.nh = {
  #   enable = true;
  #   clean.enable = true;
  #   clean.extraArgs = "--keep-since 4d --keep 3";
  #   # flake = "/etc/nixos/";
  # };

  # use the much newer nftables instead of the old iptables
  networking.nftables.enable = true;

  # clean all files in `/tmp/` during boot
  boot.tmp.cleanOnBoot = true;

  services.xserver = {
    xkb = {
      layout = "us";
      variant = "altgr-intl";
      options = "grp:alt_shift_toggle";
      model = "pc105";
    };
  };

  console = {
    useXkbConfig = true;
    earlySetup = true;
  };

  # use a new reworked configuration switcher
  system.switch = {
    enable = false;
    enableNg = true;
  };

  # enforce declarative user management
  users.mutableUsers = false;

  # customise /etc/nix/nix.conf declaratively via `nix.settings`
  nix = {
    settings = {
      # enable flakes globally
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      system-features = ["recursive-nix"];

      warn-dirty = false;

      substituters = [];

      trusted-public-keys = [];
      builders-use-substitutes = true;
    };

    # do garbage collection weekly to keep disk usage low
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 31d";
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # # Enable the OpenSSH daemon.
  # services.openssh = {
  #   enable = false;
  #   settings = {
  #     X11Forwarding = true;
  #     PermitRootLogin = "no"; # disable root login
  #     PasswordAuthentication = false; # disable password login
  #   };
  #   openFirewall = false;
  # };

  services.fwupd.enable = true;

  environment.defaultPackages = with pkgs;
    lib.mkForce [
      strace
    ]; # remove default nixos packages

  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    helix

    jujutsu
    git

    rustup

    ripgrep
    fzf

    btop # better htop alternative
    tokei # count lines of code

    rsync

    lm_sensors

    inputs.alejandra.defaultPackage.${system}
  ];
}
