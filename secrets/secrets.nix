let
  simon = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOgA5TKNxvXkIPO1CcrJl9SWMoZmDBxnlsBl4htCGcsz simon@date"
  ];

  hosts = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJr4lPy807mOR6yWcdRjubgsxlQHmCzdmdS9hyRoRZ+d root@date"
  ];

  all = simon ++ hosts;
in {

  # host keys
  "date.ctx.dev_host_ed25519.age".publicKeys = all;
  "sate.ctx.dev_host_ed25519.age".publicKeys = all;
  "late.ctx.dev_host_ed25519.age".publicKeys = all;

  "simon_password.age".publicKeys = all;
}
