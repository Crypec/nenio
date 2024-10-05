{
  pkgs,
  config,
  ...
}: {
  programs.neomutt = {
    enable = true;

    # Basic settings
    settings = {
      mbox_type = "Maildir";
      sort = "threads";
      sort_aux = "reverse-last-date-received";
      editor = "vim";
    };

    # Sidebar settings
    sidebar = {
      enable = true;
      width = 30;
      format = "%B%?F? [%F]?%* %?N?%N/?%S";
    };
  };
}
