{pkgs, inputs}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops

    <sops-nix/modules/sops>
  ];
  sops.defaultSopsFile = ../secrets/secrets.yml;
  sops.defaultSopsFormat = "yaml";
}
