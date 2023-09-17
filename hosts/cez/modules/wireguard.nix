{ config, ... }:

let
  domain = config.userdata.domain;
in
{
  sops.secrets."misc/wireguard" = {};

  networking.wg-quick.interfaces."wg" = {
    address = [ "10.0.1.2/24" ];
    dns = [ "10.0.1.1" ];
    mtu = 1380;
    privateKeyFile = config.sops.secrets."misc/wireguard".path;

    peers = [{
      publicKey = "wJMyQDXmZO4MjYRk6NK4+J6ZKWLTTZygAH+OwbPjOiw=";
      allowedIPs = [
        "10.0.1.0/24"
        "104.16.0.0/12"
      ];
      endpoint = "${domain}:51820";
      persistentKeepalive = 25;
    }];
  };
}
