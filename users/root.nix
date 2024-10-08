{
  config,
  sops,
  ...
}: {
  imports = [
    ../secrets
  ];
  users.users.root.hashedPasswordFile = sops.secrets.root-password.path;
}
