{}:
{
  sops.secrets.simon-password = {
    sopsFile = ../secrets/root-password.sops;
    format = "binary";
  };
  users.users.root.hashedPasswordFile = config.sops.secrets.root-password.path;
}
