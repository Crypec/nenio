{
  config,
  sops,
  ...
}: {
  sops.secrets.root-password = {
    sopsFile = ../secrets/root-password.sops;
    format = "binary";
  };
  users.users.root.hashedPasswordFile = config.sops.secrets.root-password.path;
}
