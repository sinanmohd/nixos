{ modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

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

      luks.devices."crypt".device =
        "/dev/disk/by-uuid/84acd784-caad-41a1-a2e4-39468d01fefd";
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/E37E-F611";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/disk/by-uuid/e063c9ad-b48f-4b6c-b94e-4c21d2238bce";
      fsType = "ext4";
    };
  };
}
