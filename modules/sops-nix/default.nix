{
  pkgs,
  inputs,
  sops,
  ...
}: {
  sops.defaultSopsFile = ../secrets/secrets.yml;
  sops.defaultSopsFormat = "yaml";
}
