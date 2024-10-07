{...}: {
  networking.firewall.enable = false;
  services.openssh = {
    enable = true;

    ports = [49151];
    openFirewall = true;

    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
        bits = 4096;
      }
    ];

    # it may be worth investigation if we should set this flag to `true` in the future
    startWhenNeeded = false;

    settings = {
      PermitRootLogin = "prohibit-password";

      PasswordAuthentication = false;
      X11Forwarding = false;
      UseDns = true;
      StrictModes = true;
      PrintMotd = true;
    };
  };
}
