{pkgs, ...}: {
  imports = [
    ./direnv.nix
    ./zsh.nix
  ];

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
        nvim = "hx";
        nano = "hx";
        tree = "exa --tree";
        cat = "bat";
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
        add_newline = false;

        format = ''[╭{nu} ](bold green)$username$directory$battery$all$line_break$character'';

        right_format = "$git_branch$git_state$git_status$time$cmd_duration";

        character = {
          success_symbol = "[╰─>](bold green)";
          error_symbol = "[╰─>](bold red)";
        };

        git_branch = {
          format = "[ $symbol$branch]($style) ";
          style = "cyan";
        };

        hostname = {
          ssh_only = false;
          format = "[@$hostname](bold blue) ";
        };

        directory = {
          format = "[](fg:#a3ca5c bg:none)[$path]($style)[ ](fg:#a3ca5c bg:none)";
          style = "fg:#000000 bg:#a3ca5c";
          truncate_to_repo = false;
        };

        username.show_always = true;

        time.disabled = false;

        cmd_duration = {
          min_time = 0;
          disabled = false;
        };

        battery.disabled = false;
      };
    };
    zoxide = {
      enable = true;
    };
    bat = {
      enable = true;
      config = {
        theme = "TwoDark";
      };
    };
  };
}
