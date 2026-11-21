{
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "sd_mod"
    "r8169"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  environment.systemPackages = with pkgs; [ mergerfs ];

  environment.etc.crypttab.text = ''
    parity1 /dev/disk/by-partlabel/disk-parity1-data /etc/secrets/hdd.key luks,nofail
    disk1   /dev/disk/by-partlabel/disk-disk1-data   /etc/secrets/hdd.key luks,nofail
    disk2   /dev/disk/by-partlabel/disk-disk2-data   /etc/secrets/hdd.key luks,nofail
  '';

  fileSystems."/mnt/storage" = {
    device = "/mnt/disk*";
    fsType = "fuse.mergerfs";
    depends = [
      "/mnt/disk1"
      "/mnt/disk2"
    ];
    options = [
      "category.create=mfs"
      "cache.files=partial"
      "dropcacheonclose=true"
      "moveonenospc=true"
      "minfreespace=50G"
      "fsname=storage"
      "nofail"
    ];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];

  services.snapraid = {
    enable = true;
    dataDisks = {
      d1 = "/mnt/disk1";
      d2 = "/mnt/disk2";
    };
    parityFiles = [ "/mnt/parity1/snapraid.parity" ];
    contentFiles = [
      "/var/snapraid.content"
      "/mnt/disk1/snapraid.content"
      "/mnt/disk2/snapraid.content"
    ];
    exclude = [
      "*.!qB"
      "*.part"
      "/lost+found/"
    ];
    sync.interval = "03:00";
    scrub.interval = "Mon *-*-* 05:00:00";
  };

  networking.useDHCP = lib.mkDefault true;

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
  };
}
