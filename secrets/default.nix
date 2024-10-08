{
  pkgs,
  sops,
  ...
}: {
  sops = {
    defaultSopsFile = ../secrets/secrets.json;
    defaultSopsFormat = "json";
    age = {
      generateKey = true;
      sshKeyPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
      ];
    };
  };

  sops.secrets = {
    # date_root_disk_key = {};
    # simon_user_password = {};
    # root_user_password = {};
  };

  environment.systemPackages = [
    pkgs.sops
    pkgs.ssh-to-age
  ];
}
