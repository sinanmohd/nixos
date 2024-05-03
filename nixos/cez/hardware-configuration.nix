{ modulesPath, pkgs, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    kernelParams = [ "quiet" ];
    loader.systemd-boot.enable = true;

    plymouth = {
      enable = true;
      theme = "lone";
      themePackages = with pkgs; [ adi1090x-plymouth-themes ];
    };

    initrd = {
      systemd.enable = true;
      kernelModules = [ "amdgpu" ];
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
