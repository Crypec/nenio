{ pkgs, ... }:

{

  imports = [ ];

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;

      shell = {
        program = "${pkgs.nushell}/bin/nu";
        # args = [
        #   "options"
        #   "--default-shell"
        #   "${pkgs.nushell}/bin/nu"
        # ];
      };

      keyboard.bindings = [
        {
          key = "Return";
          mods = "Control|Shift";
          action = "SpawnNewInstance";
        }
      ];
    };
  };

}
