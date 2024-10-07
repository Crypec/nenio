{pkgs, ...}: {
  services.pcscd.enable = true;
  programs.gnupg = {
    agent = {
      pinentryPackage = pkgs.pinentry-curses;
      enable = true;
      enableSSHSupport = true;
    };
  };
}
