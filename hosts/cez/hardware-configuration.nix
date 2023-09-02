{ modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    kernelModules = [ "kvm-amd" ];
    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "sd_mod"
        "sdhci_pci"
      ];
      luks.devices = {
        "cryptroot".device = "/dev/disk/by-uuid/445abd75-6887-4b10-8483-a4be94f1fffd";
        "crypthome".device = "/dev/disk/by-uuid/b1f57828-d0c3-4b0b-9d32-5e7e96651eda";
      };
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/1df57eaf-50cd-405d-85ef-ccd1f2649227";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/EE3C-1135";
      fsType = "vfat";
    };
    "/home" = {
      device = "/dev/disk/by-uuid/c6649ef3-f96d-4a11-ae20-d8d937d8a8e4";
      fsType = "ext4";
    };
  };
}
