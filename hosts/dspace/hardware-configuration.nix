{ lib, modulesPath, ... }:

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
      device = "/dev/disk/by-uuid/c5b1077e-52e8-4249-8bd7-d53eafa41f5a";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/9787-FFFE";
      fsType = "vfat";
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
