{
  config,
  sops,
  ...
}: {
  users.users.root.hashedPasswordFile = sops.secrets.root-password.path;
}
