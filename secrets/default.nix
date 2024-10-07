{pkgs, sops, ...}:
{
  sops.defaultSopsFile = ./secrets.yaml; 
  sops.defaultSopsFormat = "yaml";

  environment.systemPackages = [
    pkgs.sops
    pkgs.ssh-to-age
  ];
}
