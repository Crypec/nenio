{ pkgs, inputs, stylix, ... }:
{
  programs.enable.stylix = true;

  stylix = {
    enable = true;
    autoEnable = true;
    # image = "${../../misc/wallpapers/ringstrasse.jpg}";

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };
  };
}
