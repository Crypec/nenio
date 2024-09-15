{ config, pkgs, ... }:

{
  # Enable KVM virtualization
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;

  # Enable QEMU and related tools
  virtualisation.libvirtd.qemu.runAsRoot = true;

  environment.systemPackages = with pkgs; [
    qemu
    OVMF
  ];
}
