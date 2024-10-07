{pkgs, sops, ...}:
{

  sops = {
    defaultSopsFile = ./secrets.yaml; 
    defaultSopsFormat = "yaml";
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  };

  environment.systemPackages = [
    pkgs.sops
    pkgs.ssh-to-age
  ];
}
