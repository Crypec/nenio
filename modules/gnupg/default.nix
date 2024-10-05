{...}:
{
  programs.gnupg = {
    agent = {
      enable = true; 
      enableSSHSupport = true;
    };
    dirmngr.enable = true;
  }; 
}
