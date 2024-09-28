{
  config,
  pkgs,
  ...
}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;

    qemu.runAsRoot = false;

    qemu.ovmf.enable = true;
  };

  environment.systemPackages = with pkgs; [
    qemu
    OVMF
  ];
}
