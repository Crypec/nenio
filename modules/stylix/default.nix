{
  pkgs,
  stylix,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = true;

    targets.plymouth.enable = false;
    targets.console.enable = false;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/brewer.yaml";
    image = ../../misc/wallpapers/ringstrasse.jpg;

    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 20;
    };

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
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

      sizes = {
        applications = 12;
        terminal = 12;
        desktop = 10;
        popups = 10;
      };
    };
  };
}
