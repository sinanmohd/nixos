{ lib, ... }:
{
  options.global.disk = {
    master = lib.mkOption {
      type = lib.types.str;
      default = "nvme0n1";
      description = "Used by disko to make /boot and /root";
    };
  };
}
