{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    yubikey-manager
  ];

  services.pcscd.enable = true;

  hardware.gpgSmartcards.enable = true; # for yubikey
}
