{ modulesPath, nixos-hardware, config, ... }:

{
  imports = [
    nixos-hardware.nixosModules.lenovo-ideapad-16ach6
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # override nixos-hardware values
  hardware.nvidia.prime.offload.enable = false;
  hardware.amdgpu.initrd.enable = false;
  services.xserver.videoDrivers = [ "modesetting" ];

  swapDevices = [{
    device = "/swapfile";
    size = 14 * 1024; # 14GB
  }];

  boot = {
    loader.systemd-boot.enable = true;
    blacklistedKernelModules = [ "k10temp" ];
    extraModulePackages = with config.boot.kernelPackages; [ zenpower ];

    initrd = {
      systemd.enable = true;
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
