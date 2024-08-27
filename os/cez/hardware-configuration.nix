{ modulesPath, nixos-hardware, lib, ... }:

{
  imports = [
    nixos-hardware.nixosModules.lenovo-ideapad-16ach6
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # override nixos-hardware values
  hardware.nvidia.prime.offload.enable = false;
  services.xserver.videoDrivers = [ "modesetting" ];

  specialisation.nvidia.configuration = {
    hardware.nvidia = {
      open = true;
      nvidiaSettings = false;
      prime.sync.enable = true;
    };

    services = {
      xserver.videoDrivers = [ "nvidia" ];
      tlp.settings.PLATFORM_PROFILE_ON_AC = lib.mkForce "performance";
    };
    nixpkgs.config.allowUnfreePredicate =
      pkg: builtins.elem (lib.getName pkg) [ "nvidia-x11" ];
  };

  boot = {
    loader.systemd-boot.enable = true;

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
