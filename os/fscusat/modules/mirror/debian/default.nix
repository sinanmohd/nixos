{ config, ... }:
let
  name = config.global.userdata.name;
  email = config.global.userdata.email;
in
{
  imports = [ ./ftpsync.nix ];

  services.ftpsync = {
    enable = true;

    settings = {
      RSYNC_HOST = "ossmirror.mycloud.services";
      RSYNC_PATH = "debian";
      ARCH_INCLUDE = "amd64 riscv64";

      INFO_MAINTAINER = "${name} <${email}>";
      INFO_COUNTRY = "IN";
      INFO_LOCATION = "Kochi, Kerala";
      INFO_THROUGHPUT = "1Gb";
      MAILTO = email;
    };
  };
}
