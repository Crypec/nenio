{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ../tofi
    ../waybar
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;

    # FIXME(Simon): enable this again. This is just a dirty workaround to fix my nixos config
    # FIXME(Simon): from not compiling with the `package = pkgs.swayfx` option set.
    checkConfig = false;

    wrapperFeatures.gtk = true;
    systemd.enable = true;

    config = rec {
      modifier = "Mod4";

      menu = "tofi-drun --drun-launch=true";
      bars = [{command = "${pkgs.waybar}/bin/waybar";}];

      down = "j";
      up = "k";
      left = "h";
      right = "l";

      keybindings = let
        mod = config.wayland.windowManager.sway.config.modifier;
      in
        lib.mkOptionDefault {
          "${mod}+Shift+e" = "exit";
          "${mod}+Shift+w" = "kill";
          "${mod}+space" = "exec tofi-drun --drun-launch=true";
          "${mod}+Shift+f" = "exec firefox";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        };

      input = {
        "type:keyboard" = {
          repeat_delay = "300";
          repeat_rate = "100";
        };
        # "type:touchpad" = {
        #   dwt = "enabled";
        #   middle_emulation = "enabled";
        #   natural_scroll = "enabled";
        #   tap = "enabled";
        # };
      };

      window.border = 5;
      focus.followMouse = true;
      gaps = {
        outer = 3;
        inner = 5;
        smartBorders = "off";
        smartGaps = false;
      };

      output = {
        HDMI-A-1 = {
          mode = "1920x1080@119.982Hz";
          pos = "3445 1178";
          transform = "270";
          scale = "1.0";
          scale_filter = "smart";
          adaptive_sync = "off";
          dpms = "on";
        };
        DP-2 = {
          mode = "1920x1080@390.297Hz";
          pos = "1525 1745";
          transform = "normal";
          scale = "1.0";
          scale_filter = "smart";
          adaptive_sync = "off";
          dpms = "on";
        };
        DP-1 = {
          mode = "1920x1080@360.0Hz";
          pos = "445 1178";
          transform = "270";
          scale = "1.0";
          scale_filter = "smart";
          adaptive_sync = "off";
          dpms = "on";
        };
      };

      # defaultWorkspace = "2";

      # workspaceOutputAssign = {
      # };

      # # Set variables
      # variables = {
      #   drun = "tofi-drun --drun-launch=true";
      # };

      # Keybindings
      # keybindings = {
      #   "Mod+Shift+d" = "exec $drun";
      # };

      # Use kitty as default terminal
      terminal = "alacritty";
      startup = [
        {command = "swaybg -m fill -i ${../../misc/wallpapers/ringstrasse.jpg}";}
        {command = "lxqt-policykit-agent";}
      ];
    };
    extraConfig = "
      default_border pixel 2
      focus outut DP-3
      for_window [class='.*'] split toggle
      for_window [app_id='.*'] split toggle
      # default_orientation vertical
    ";
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      show-failed-attempts = true;
    };
  };

  services.mako = {
    enable = true;
  };

  home.packages = with pkgs; [
    alacritty
    pavucontrol
    thunderbird
    chromium
    strawberry-qt6
    signal-desktop-beta
    tor-browser
    jellyfin-media-player
    virt-manager

    gurk-rs
    tofi

    wl-clipboard
    wdisplays # graphical output manager
    lxqt.lxqt-policykit

    # waypipe # forward application over ssh
    # wev # wayland event monitor
    wl-clipboard # cli tool to manage wayland clipboard
    # wl-mirror # emulation for “mirror display” mode
    # wlr-randr # output management that actually works
  ];

  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "sway";
    XDG_CURRENT_DESKTOP = "sway";

    WLR_RENDERER = "vulkan";

    _JAVA_AWT_WM_NONREPARENTING = 1;
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=on";

    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
    GDK_DPI_SCALE = 1;

    MOZ_ENABLE_WAYLAND = 1;

    NIXOS_OZONE_WL = 1;

    QT_QPA_PLATFORM = "wayland";

    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    SDL_VIDEODRIVER = "wayland";
    WLR_NO_HARDWARE_CURSORS = 1;
  };
}
