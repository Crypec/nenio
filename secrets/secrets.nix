let
  simon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFIObEXlIhuWihDTjnjAbTwhwvBEWjnNsVkCL0Y/8QZv simon@date";

  date = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPJDyIr/FSz1cJdcoW69R+NrWzwGK/+3gJpqD1t8L2zE";
  # system2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKzxQgondgEYcLpcPdJLrTdNgZ2gznOHCAxMdaceTUT1";
  # systems = [ system1 system2 ];
in {
  "passwords.age".publicKeys = [simon];
  # "secret2.age".publicKeys = users ++ systems;
}
