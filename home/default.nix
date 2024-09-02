{ pkgs, ... }:

{
  imports = [
    ./alacritty
    ./helix
    ./shell

    ./sway
    ./firefox
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "simon";
    homeDirectory = "/home/simon";

    sessionVariables = rec {
      EDITOR = "hx";
      GIT_EDITOR = EDITOR;
    };

    packages = with pkgs; [ ];
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
