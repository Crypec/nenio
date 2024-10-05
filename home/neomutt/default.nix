{
  pkgs,
  config,
  ...
}: {

  programs.mbsync.enable = true;
  programs.msmtp.enable = true; 
  programs.mujmap.enable = true;

  programs.notmuch = {
    enable = true;
    hooks = {
      preNew = "mbsync --all";
    };
  };

  programs = {
    neomutt = {
      enable = true;

      # Basic settings
      settings = {
        mbox_type = "Maildir";
        sort = "threads";
        sort_aux = "reverse-last-date-received";

      };

      editor = "hx";
      vimKeys = true;

      # Sidebar settings
      sidebar = {
        enable = true;
        width = 30;
        format = "%B%?F? [%F]?%* %?N?%N/?%S";
      };
    };
  };
}
