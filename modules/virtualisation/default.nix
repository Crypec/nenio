{ config, pkgs, ... }:

{
  # Enable KVM virtualization
  # virtualisation.libvirtd.enable = true;
  # virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;

  # # Enable QEMU and related tools
  # virtualisation.libvirtd.qemu.runAsRoot = true;

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
