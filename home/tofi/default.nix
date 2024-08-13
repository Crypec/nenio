{ config, pkgs, ... }:

{

  imports = [ ];
  programs.tofi = {
    enable = true;
    settings = {
      font = "Comic Mono";
      font-size = 11;
      text-color = "#FFFFFF";
      prompt-color = "#FFFFFF";
      prompt-background = "#110855";
      prompt-background-padding = "8, 12";
      prompt-background-corner-radius = 10;
      selection-color = "#FFFFFF";
      selection-background = "#553355";
      selection-background-padding = "8, 12";
      selection-background-corner-radius = 10;
      selection-match-color = "#EE33EE";
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
      border-color = "#999999";
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
}
