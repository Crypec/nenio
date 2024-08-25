{ config, lib, ... }:

{

  imports = [ ];
  programs.tofi = {
    enable = true;
    settings = {
      font = "Comic Mono";
      font-size = 11;
      prompt-background-padding = "8, 12";
      prompt-background-corner-radius = 10;
      selection-background-padding = "8, 12";
      selection-background-corner-radius = 10;
      prompt-text = "Run:";
      prompt-padding = 22;
      placeholder-text = "Application";
      result-spacing = 30;
      horizontal = true;
      min-input-width = 300;
      anchor = "top";
      width = "70%";
      height = 70;
      background-color = "#111111";
      outline-width = 0;
      border-width = 5;
      corner-radius = 30;
      clip-to-padding = false;
      padding-top = 13;
      padding-left = 17;
      require-match = false;
      hide-input = false;

      margin-top = "5%";
      auto-accept-single = true;
    };
  };

  # https://github.com/philj56/tofi/issues/115#issuecomment-1701748297
  # rebuild tofi cache after every home-manager reload, such that it can find all applications
  home.activation = {
    regenerateTofiCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      tofi_cache=${config.xdg.cacheHome}/tofi-drun
      [[ -f "$tofi_cache" ]] && rm "$tofi_cache"
    '';
  };
}
