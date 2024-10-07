{pkgs, sops, ...}:
{

  sops = {
    defaultSopsFile = ./secrets.yaml; 
    defaultSopsFormat = "yaml";
    age = {
      generateKey = true;
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
  };

  sops.secrets = {
    date.sopsFile = ./date.yaml;
  };

  environment.systemPackages = [
    pkgs.sops
    pkgs.ssh-to-age
  ];
}
