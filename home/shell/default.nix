{pkgs, config, ...}: {
  imports = [];

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs = {
    nushell = {
      enable = true;

      configFile = {
        text = ''
          $env.config = {
            show_banner: false,
            edit_mode: vi,
          }
          $env.EDITOR = 'hx'
          $env.GIT_EDITOR = 'hx'
        '';
      };

      shellAliases = {
        vi = "hx";
        vim = "hx";
        nano = "hx";
        tree = "exa --tree";
      };
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = true;
        # character = {
        #   success_symbol = "[➜](bold green)";
        #   error_symbol = "[➜](bold red)";
        # };
      };
    };
    zoxide = {
      enable = true;
    };
  };
}
