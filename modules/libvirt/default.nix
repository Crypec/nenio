{pkgs, ...}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = false;

      ovmf = {
        enable = true;
        packages = with pkgs; [
          OVMFFull.fd
        ];
      };
    };

    # allow more than host to shutdown at the same time
    parallelShutdown = 255;
  };

  # environment.systemPackages = with pkgs; [
  #   qemu
  #   OVMF
  # ];

  systemd.tmpfiles.rules = [
    "d /var/lib/libvirt/iso-files 0771 root libvirtd"
  ];
}
