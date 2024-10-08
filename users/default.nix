{sops, ...}:
{
  imports = [
    ./root.nix
    ./simon.nix
  ];

  # enforce declarative user management
  users.mutableUsers = false;
}
