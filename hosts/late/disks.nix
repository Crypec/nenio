{lib, ...}: {
  disko.devices.disk = {
    nvme0n1 = {
      type = "disk";
      device = "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            size = "2G";
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
          primary = {
            size = "100%";
            content = {
              type = "luks";
              name = "nixos";
              askPassword = true;
              initrdUnlock = true;

              settings.allowDiscards = true;

              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
