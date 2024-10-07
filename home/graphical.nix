{pkgs, ...}: {
  imports = [
    ./alacritty

    ./gnupg
    ./neomutt
    ./vdirsyncer

    ./sway
    ./firefox
  ];
}
