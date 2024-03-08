{ modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
    };

    kernelModules = [ "kvm-intel" ];
    initrd.availableKernelModules = [
      "uhci_hcd"
      "ehci_pci"
      "ata_piix"
      "hpsa"
      "usb_storage"
      "usbhid"
      "sd_mod"
      "sr_mod"
    ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/99fc38a8-9003-4ae2-98f4-e08afd9b4114";
    fsType = "ext4";
  };
}
