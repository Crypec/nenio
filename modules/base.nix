{ pkgs, lib, ... }:
let
  username = "simon";
in
{
  # ============================= User related =============================

  # use the much newer nftables instead of the old iptables
  networking.nftables.enable = true;

  # use a new reworked configuration switcher
  system.switch = {
    enable = false;
    enableNg = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.simon = {
    isNormalUser = true;
    description = "Simon";

    shell = pkgs.nushell;

    extraGroups = [
      "networkmanager"
      "wheel"
    ];

    packages = with pkgs; [
      alacritty
      eza

      thunderbird
      neomutt
      firefox
      chromium
      strawberry-qt6
      signal-desktop-beta
    ];
  };

  # given the users in this list the right to specify additional substituters via:
  #    1. `nixConfig.substituers` in `flake.nix`
  #    2. command line args `--options substituers http://xxx`
  nix.settings.trusted-users = [ username ];

  # customise /etc/nix/nix.conf declaratively via `nix.settings`
  nix.settings = {
    # enable flakes globally
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    substituters = [ ];

    trusted-public-keys = [ ];
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
      emoji = [ "Noto Color Emoji" ];
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    helix

    jujutsu
    git

    tree
    lm_sensors
  ];

  # Enable sound with pipewire.
  # sound.enable = true;
  # hardware.pulseaudio.enable = false;
  # services.power-profiles-daemon = {
  #   enable = true;
  # };
  security.polkit.enable = true;

  services = {
    dbus.packages = [ pkgs.gcr ];

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      # If you want to use JACK applications, uncomment this
      jack.enable = false;
    };

    # udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };
}
