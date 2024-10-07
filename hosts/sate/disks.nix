{lib, ...}: {
  disko.devices.disk = {
    nvme0n1 = {
      type = "disk";
      device = "/dev/sda";
      content = {
        type = "gpt";
        partitions = {
          esp = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [
                "umask=0077"
                "dmask=0077"
              ];
            };
          };
          mdadm = {
            size = "100%";
            content = {
              type = "mdraid";
              name = "md0";
              # device = "/dev/md0";
            };
          };
        };
      };
    };
    nvme1n1 = {
      type = "disk";
      device = "/dev/sdb";
      content = {
        type = "gpt";
        partitions = {
          esp = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              # mountpoint = "/boot"; # don't mount the second boot drive
              mountOptions = [
                "umask=0077"
                "dmask=0077"
              ];
            };
          };
          mdadm = {
            size = "100%";
            content = {
              type = "mdraid";
              name = "md0";
            };
          };
        };
      };
    };
  };

  disko.devices.mdadm = {
    md0 = {
      type = "mdadm";
      level = 1;
      content = {
        type = "luks";
        name = "nixos";
        askPassword = true;
        extraFormatArgs = [
          "--iter-time 10"
          "--key-size 512"
          "--hash sha512"
          "--use-random"
        ];
        initrdUnlock = true;
        content = {
          type = "filesystem";
          format = "ext4";
          mountpoint = "/";
        };
      };
    };
  };
}
