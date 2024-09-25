{ lib, ... }: {
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
