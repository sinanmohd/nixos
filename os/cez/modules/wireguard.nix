{ config, pkgs, ... }:
let
  domain = config.global.userdata.domain;
  wgIface = "kay";

  helper = pkgs.writeShellApplication {
    name = "vpn";
    text = ''
      note() {
              command -v notify-send > /dev/null &&
                      notify-send "󰒒  VPN" "$1"

              printf "\n%s\n" "$1"
      }

      if systemctl status "wg-quick-${wgIface}.service" > /dev/null 2>&1; then
              sudo -A systemctl stop "wg-quick-${wgIface}.service" &&
                      note "connection was dropped"
      else
              sudo -A systemctl start "wg-quick-${wgIface}.service" &&
                      note "traffic routed through ${wgIface}"
      fi
    '';
  };
in
{
  sops.secrets."misc/wireguard" = { };
  environment.systemPackages = [ helper ];

  networking.wg-quick.interfaces = {
    ${wgIface} = {
      autostart = false;
      address = [ "10.0.1.2/24" ];
      dns = [ "10.0.1.1" ];
      mtu = 1412;
      privateKeyFile = config.sops.secrets."misc/wireguard".path;

      peers = [
        {
          publicKey = "wJMyQDXmZO4MjYRk6NK4+J6ZKWLTTZygAH+OwbPjOiw=";
          allowedIPs = [
            "10.0.1.0/24"
            "104.16.0.0/12"
            "172.64.0.0/13"
          ];
          endpoint = "${domain}:51820";
          persistentKeepalive = 25;
        }
      ];
    };

    bud = {
      autostart = true;
      address = [ "10.54.132.2/24" ];
      dns = [ "10.54.132.1" ];
      mtu = 1420;
      privateKeyFile = config.sops.secrets."misc/wireguard".path;

      peers = [
        {
          publicKey = "O2GRMEWf22YRGKexHAdg1fitucTZ/U/om2MWEJMeyFQ=";
          allowedIPs = [ "10.54.132.0/24" ];
          endpoint = "dev.bud.studio:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
