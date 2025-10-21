{ config, ... }:
{
  sops.secrets."misc/wireguard" = { };

  networking.wg-quick.interfaces.bud = {
    autostart = false;
    address = [ "10.54.132.2/24" ];
    mtu = 1420;
    privateKeyFile = config.sops.secrets."misc/wireguard".path;

    peers = [
      {
        publicKey = "O2GRMEWf22YRGKexHAdg1fitucTZ/U/om2MWEJMeyFQ=";
        allowedIPs = [ "10.54.132.0/24" ];
        endpoint = "primary.k8s.bud.studio:51820";
        persistentKeepalive = 25;
      }
    ];
  };
}
