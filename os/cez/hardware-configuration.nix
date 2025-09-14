{
  modulesPath,
  nixos-hardware,
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    nixos-hardware.nixosModules.lenovo-ideapad-16ach6
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware = {
    bluetooth.enable = true;
    # override nixos-hardware values
    nvidia.prime.offload.enable = false;
  };
  services.xserver.videoDrivers = [ "modesetting" ];

  swapDevices = [
    {
      device = "/swapfile";
      size = 14 * 1024; # 14GB
    }
  ];

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages;
    loader.systemd-boot.enable = true;
    blacklistedKernelModules = [ "k10temp" ];
    extraModulePackages = with config.boot.kernelPackages; [ zenpower ];

    initrd.luks.devices."crypt".device = "/dev/disk/by-uuid/84acd784-caad-41a1-a2e4-39468d01fefd";
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

  specialisation.nvidia.configuration = {
    boot = {
      kernelParams = [ "transparent_hugepage=always" ];
      kernel.sysctl."vm.max_map_count" = 2147483642;
    };

    environment.variables = {
      DRI_PRIME = 1;
      __NV_PRIME_RENDER_OFFLOAD = 1;
      __VK_LAYER_NV_optimus = "NVIDIA_only";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };

    hardware.nvidia = {
      open = true;
      nvidiaSettings = false;
      prime.sync.enable = true;
    };

    services = {
      xserver.videoDrivers = [ "nvidia" ];
      tlp.settings.PLATFORM_PROFILE_ON_AC = lib.mkForce "performance";
    };
  };
}
