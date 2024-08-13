{ ... }:

{

  imports = [ ];

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.helix = {
    enable = true;
    defaultEditor = true;
  };
}
