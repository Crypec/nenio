{...}:
{
  networking.firewall.enable = false;
  services.openssh = {
    enable  = true;

    ports = [ 49151 ];
    openFirewall = true;

    # it may be worth investigation if we should set this flag to `true` in the future
    startWhenNeeded = false;

    settings = {
      PermitRootLogin = "prohibit-password";

      PasswordAuthentication = false;
      X11Forwarding = false;
      UseDns = true;
      StrictModes =  true;
      PrintMotd = true;
    };
  };
}
