{
  config,
  lib,
  ...
}: {
  imports = [];
  programs.tofi = {
    enable = true;
    settings = {
      hide-cursor = true;
      text-cursor = true;

      history = true;
      fuzzy-match = false;
      matching-algorithm = "prefix";
      require-match = true;
      auto-accept-single = true;
      hide-input = false;
      hidden-character = "*";
      drun-launch = true;
      terminal = "alacritty";
      late-keyboard-init = false;
      multi-instance = false;
      ascii-input = false;

      # STYLE OPTIONS;
      font-features = "";
      font-variations = "";

      # background-color = #000;
      outline-width = 0;
      # outline-color = #080800;
      border-width = 1;
      # border-color = #686868;
      # text-color = #becbcb;
      prompt-text = "❯ ";
      prompt-padding = 0;
      # prompt-color = #ffffff;
      # prompt-background = #00000000;
      prompt-background-padding = 0;
      prompt-background-corner-radius = 0;
      placeholder-text = "";
      # placeholder-color = #FFFFFFA8;
      # placeholder-background = #00000000;
      placeholder-background-padding = 0;
      placeholder-background-corner-radius = 0;
      # input-color = #ffffff;
      # input-background = #00000000;
      input-background-padding = 0;
      input-background-corner-radius = 0;
      text-cursor-style = "underscore";
      # text-cursor-color = #ffffff;
      # ; text-cursor-background = ;
      text-cursor-corner-radius = 0;
      # ; text-cursor-thickness = ;
      # ; default-result-color = ;
      # default-result-background = #00000000;
      default-result-background-padding = 0;
      default-result-background-corner-radius = 0;

      num-results = 10;
      selection-padding = 0;
      selection-background-padding = 0;
      selection-background-corner-radius = 0;
      result-spacing = 5;

      # ; min-input-width = ;
      width = 300;
      height = 350;

      corner-radius = 0;
      anchor = "center";
      exclusive-zone = -1;
      output = "";
      scale = true;
      margin-top = 0;
      margin-bottom = 0;
      margin-left = 0;
      margin-right = 0;
      padding-top = "3%";
      padding-bottom = 0;
      padding-left = "1%";
      padding-right = 0;
      clip-to-padding = true;
      horizontal = false;
      hint-font = false;
    };
  };

  # https://github.com/philj56/tofi/issues/115#issuecomment-1701748297
  # rebuild tofi cache after every home-manager reload, such that it can find all applications
  home.activation = {
    regenerateTofiCache = lib.hm.dag.entryAfter ["writeBoundary"] ''
      tofi_cache=${config.xdg.cacheHome}/tofi-drun
      [[ -f "$tofi_cache" ]] && rm "$tofi_cache"
    '';
  };
}
