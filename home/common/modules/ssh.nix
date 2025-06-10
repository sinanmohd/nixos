{ config, ... }:
let
  domain = config.global.userdata.domain;
in
{
  programs.ssh = {
    enable = true;
    compression = true;

    extraConfig = ''
      Host kay
        HostName ${domain}
    '';
  };
}
