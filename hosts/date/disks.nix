{lib, ...}: {
  disko.devices.disk = {
    one = {
      type = "disk";
      device = "/dev/sda";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            size = "500M";
            type = "EF00";
            content = {
              type = "mdraid";
              name = "boot";
            };
          };
          primary = {
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "pool";
            };
          };
        };
      };
    };
  };

  disko.devices.mdadm = {
    boot = {
      type = "mdadm";
      level = 1;
      metadata = "1.2";
      content = {
        type = "filesystem";
        format = "vfat";
        mountpoint = "/boot";
      };
    };
    md0 = {
      type = "mdadm";
      level = 1;
      content = {
        type = "luks";
        name = "crypted";
        settings = {
          # disable settings.keyFile if you want to use interactive password entry
          #passwordFile = "/tmp/secret.key"; # Interactive        settings = {
          allowDiscards = true;
          # keyFile = "/tmp/secret.key";
        };
        content = {
          type = "filesystem";
          format = "ext4";
          mountpoint = "/";
        };
      };
    };
  };
}
