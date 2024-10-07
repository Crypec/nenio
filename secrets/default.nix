{
  pkgs,
  sops,
  ...
}: {
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      generateKey = true;
      sshKeyPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
      ];
    };
  };

  sops.secrets = {
    # "date/root_disk_key" = {};
  };

  environment.systemPackages = [
    pkgs.sops
    pkgs.ssh-to-age
  ];
}
