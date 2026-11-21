{
  disko.devices.disk =
    let
      hdd = id: mountpoint: {
        type = "disk";
        device = "/dev/disk/by-id/${id}";
        content = {
          type = "gpt";
          partitions.data = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "xfs";
              inherit mountpoint;
              mountOptions = [ "noatime" ];
            };
          };
        };
      };
    in
    {
      nvme = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WDC_WDS250G1B0C-00S6U0_190704648905";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
      parity1 = hdd "ata-WDC_WD181KRYZ-01AGBB0_3WH340HJ" "/mnt/parity1";
      disk1 = hdd "ata-WDC_WUH721818ALE6L0_3GGTXVHE" "/mnt/disk1";
      disk2 = hdd "ata-WDC_WUH721818ALE6L0_3WH65PAJ" "/mnt/disk2";
    };
}
