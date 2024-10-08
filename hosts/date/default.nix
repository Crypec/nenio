# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./disks.nix
    ../../modules/graphical
  ];

  # settings.system = {
  #   isHeadless = false;
  # };

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    extraModulePackages = [];
    kernelModules = ["kvm-amd"];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      enable = true;

      systemd = {
        enable = true;
        emergencyAccess = true;
      };

      kernelModules = [];
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "sd_mod"
      ];
    };
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 64 * 1024; # 64GB
    }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkForce true;

  # nixpkgs.hostPlatform = lib.mkDefaul "x86_64-linux-v3";
  hardware.cpu.amd.updateMicrocode = true;

  networking = {
    hostName = "date";
    domain = "ctx.dev";

    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
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

  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    enableRedistributableFirmware = true;

    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        # trying to fix `WLR_RENDERER=vulkan` in sway
        vulkan-validation-layers
      ];
    };
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "560.35.03";
        sha256_64bit = "sha256-8pMskvrdQ8WyNBvkU/xPc/CtcYXCa7ekP73oGuKfH+M=";
        sha256_aarch64 = "sha256-s8ZAVKvRNXpjxRYqM3E5oss5FdqW+tv1qQC2pDjfG+s=";
        openSha256 = "sha256-/32Zf0dKrofTmPZ3Ratw4vDM7B+OgpC4p7s+RHUjCrg=";
        settingsSha256 = "sha256-kQsvDgnxis9ANFmwIwB7HX5MkIAcpEEAHc8IBOLdXvk=";
        persistencedSha256 = "sha256-E2J2wYYyRu7Kc3MMZz/8ZIemcZg68rkzvqEwFAL3fFs=";
      };
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # console = {
  #   # font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
