{lib, ...}: {
  imports = [];

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor = {
        auto-save = true;
        auto-pairs = true;
        auto-format = true;

        true-color = true;

        undercurl = true;
        cursorline = false;

        text-width = 120;

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
