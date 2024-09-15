{ ... }:

{

  imports = [ ];

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs = {
    nushell = {
      enable = true;

      # configFile.text = "
      #   show_banner: false
      # ";

      configFile = {
        text = ''
          $env.config = {
            show_banner: false,
          }
          $env.EDITOR = 'hx'
          $env.GIT_EDITOR = 'hx'
        '';
      };

      shellAliases = {
        vi = "hx";
        vim = "hx";
        nano = "hx";
      };
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    starship = {
      enable = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
  };
}
