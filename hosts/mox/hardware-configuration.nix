{ modulesPath, ... }:

{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  boot.initrd.availableKernelModules = [
    "ata_piix"
    "uhci_hcd"
    "virtio_pci"
    "virtio_scsi"
    "sd_mod"
    "sr_mod"
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/547074b4-4d61-4968-a94f-4f97e1fa2c3c";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/C634-FE6A";
      fsType = "vfat";
    };
  };
}
