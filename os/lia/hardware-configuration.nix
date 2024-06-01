{ modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    loader.systemd-boot.enable = true;
    kernelModules = [ "kvm-amd" ];

    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/9ad3550b-8c9a-4541-8fac-7af185599446";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/6111-05EC";
      fsType = "vfat";
    };
  };
}
