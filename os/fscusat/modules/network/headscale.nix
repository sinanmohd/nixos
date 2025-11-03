{ config, ... }:
let
  headScaleUrl = "https://headscale.${config.global.userdata.domain}";
  user = config.global.userdata.name;
in
{
  sops.secrets."misc/headscale" = { };
  networking.firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];

  services.tailscale = {
    enable = true;
    interfaceName = "headscale";
    openFirewall = true;

    authKeyFile = config.sops.secrets."misc/headscale".path;
    extraUpFlags = [
      "--login-server=${headScaleUrl}"
      "--operator=${user}"
      "--accept-routes=false"
      "--advertise-exit-node"
    ];
  };
}
