{pkgs, ...}:
{
  programs.rbw = {
    enable = true;
    settings = {
      email = "simon.kunz@pm.me";
      base_url = "https://vault.ctx.dev";
      ui_url = "https://vault.ctx.dev";
      pinentry = pkgs.pinentry-gnome3;
    };
  };
}
