{
  config,
  pkgs,
  lib,
  inputs,
  alejandra,
  ...
}: {
  # use the much newer nftables instead of the old iptables
  networking.nftables.enable = true;

  services.xserver = {
    xkb = {
      layout = "us";
      variant = "altgr-intl";
      options = "grp:alt_shift_toggle";
      model = "pc105";
    };
  };

  console.keyMap = "us";

  # use a new reworked configuration switcher
  system.switch = {
    enable = false;
    enableNg = true;
  };

  # customise /etc/nix/nix.conf declaratively via `nix.settings`
  nix.settings = {
    # enable flakes globally
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    substituters = [];

    trusted-public-keys = [];
    builders-use-substitutes = true;
  };

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 31d";
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

  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons

      # normal fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts

      # nerdfonts
      nerdfonts
      # (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
    ];

    # use fonts specified by user rather than default ones
    enableDefaultPackages = true;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = [
        "Noto Serif"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Noto Sans"
        "Noto Color Emoji"
      ];
      monospace = [
        "JetBrainsMono Nerd Font"
        "Noto Color Emoji"
      ];
      emoji = ["Noto Color Emoji"];
    };
  };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = false;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = false;
  };

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

    inputs.agenix.packages."${system}".default
    inputs.alejandra.defaultPackage.${system}
  ];
}
