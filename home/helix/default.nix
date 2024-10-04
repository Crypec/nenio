{lib, ...}: {
  imports = [];

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = lib.mkForce "naysayer";
      editor = {
        auto-save = true;
        true-color = true;
        auto-pairs = true;

        undercurl = true;
        cursorline = false;

        text-width = 120;
        rulers = [120];

        lsp = {
          display-messages = false;
        };

        soft-wrap = {
          enable = true;
        };
      };
      keys.normal = {
        esc = ["collapse_selection" "keep_primary_selection"];
      };
    };
  };
}
