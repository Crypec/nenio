# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./disks.nix

    ../../modules/common
    ../../modules/sshd
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = ["ip=dhcp"];
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      enable = true;

      systemd = {
        enable = true;
        users.root.shell = "/bin/cryptsetup-askpass";
        emergencyAccess = true;
      };

      network = {
        enable = true;
        ssh = {
          enable = true;
          port = 22;
          authorizedKeys = ["ssh-rsa AAAAyourpublic-key-here..."];
          hostKeys = ["/etc/ssh/ssh_host_ed25519_key"];
        };
      };

      kernelModules = [];
      availableKernelModules = [
        "igb"
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "sd_mod"
      ];
    };

    swraid = {
      enable = true;

      # mdadmConf = ''
      #   ARRAY /dev/md0 level=raid1 num-devices=2 metadata=1.2 name=nixos:0 UUID=363d2583:3d7916b0:9994ddf9:e8ad978d devices=/dev/nvme0n1p2,/dev/nvme1n1p2
      #   MAILADDR mdadm@ctx.dev
      # '';
    };
  };

  # swapDevices = [
  #   {
  #     device = "/swapfile";
  #     size = 128 * 1024; # 128GB
  #   }
  # ];

  # nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;

  networking = {
    hostName = "sate";
    domain = "ctx.dev";

    networkmanager.enable = false;
    useNetworkd = true;
  };

  systemd.network = {
    enable = true;
    networks = {
      wan = {
        enable = true;
        name = "enp1s0";

        networkConfig = {
          Address = "144.76.86.84/27"; # Replace with your desired static IP and subnet mask
          Gateway = "144.76.86.65"; # Replace with your router's IP address
          DNS = "8.8.8.8 1.1.1.1"; # Replace with your preferred DNS servers
        };
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /data 0750 root root"
  ];

  nix.settings.system-features = [
    "benchmark"
    "big-parallel"
    "kvm"
    "nixos-test"
    "gccarch-znver3"
  ];

  # nixpkgs = {
  #   localSystem = {
  #     system = "x86_64-linux";
  #     config = "znver3";
  #   };
  #   hostPlatform = {
  #     gcc.arch = "znver3";
  #     gcc.tune = "znver3";
  #     system = "x86_64-linux";
  #   };
  # };

  # Use the systemd-boot EFI boot loader.

  # age.secrets.disk-data.file = ../../../secrets/disk-data.age;
  # systemd.services.bcachefs-unlock-and-mount-data = {
  #   enable = true;
  #   description = "Unlock and mount /data partition";

  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "local-fs.target" ];
  #   wants = [ "local-fs.target" ];

  #   serviceConfig = {
  #     Type = "oneshot";
  #     RemainAfterExit = true;
  #     ExecStart = pkgs.writeShellScript "bcachefs-unlock-mount" ''
  #       DEV_IDENT="/dev/disks/by-uuid/293ff970-3751-426f-be12-453929466b83"
  #       MOUNT_POINT="/data"

  #       if ${pkgs.bcachefs-tools}/bin/bcachefs unlock --key-file="${config.age.secrets.disk-data.path}" "$DEV_IDENT"; then
  #         echo "Successfully unlocked bcachefs partition"
  #         if ${pkgs.util-linux}/bin/mount -t bcachefs "/dev/disk/by-label/$DEVICE_LABEL" "$MOUNT_POINT"; then
  #           echo "Successfully mounted bcachefs partition to $MOUNT_POINT"
  #         else
  #           echo "Failed to mount bcachefs partition"
  #           exit 1
  #         fi
  #       else
  #         echo "Failed to unlock bcachefs partition"
  #         exit 1
  #       fi
  #     '';
  #     ExecStop = "${pkgs.util-linux}/bin/umount /data";
  #   };
  # };

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  nixpkgs.config.allowUnfree = true;

  services.fstrim.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = lib.mkForce true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "unstable"; # Did you read the comment?
}
