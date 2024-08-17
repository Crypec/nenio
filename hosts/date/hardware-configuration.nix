# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [ "boot.shell_on_fail" ];

  # Software RAID
  boot.swraid = {
    enable = true;

    mdadmConf = ''
      ARRAY /dev/md0 level=raid1 num-devices=2 metadata=1.2 UUID=363d2583:3d7916b0:9994ddf9:e8ad978d devices=/dev/nvme0n1p2,/dev/nvme1n1p2
    '';
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ed6881af-f2fb-48ee-849b-ffd9e35d2935";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."nixos".device = "/dev/disk/by-uuid/a5d2ad09-d2e1-4ffc-a890-cc4ba37a6a35";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5DA5-D18A";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp42s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp5s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
