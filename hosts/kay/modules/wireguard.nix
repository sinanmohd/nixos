{ config, ... }:

let
  wgInterface = "wg";
  wanInterface = "ppp0";
  subnet = "10.0.1.0";
  prefix = 24;
  port = 51820;
in
{
  sops.secrets."misc/wireguard" = {};

  networking = {
    nat.enable = true;
    firewall = {
      allowedUDPPorts = [ port ];
      extraCommands = ''
        # nat datagrams comming through lanInterface to wanInterface
        iptables -t nat -I POSTROUTING 1 -s ${subnet}/${toString prefix} -o ${wanInterface} -j MASQUERADE

        # allow all traffic on lanInterface interface
        iptables -I INPUT 1 -i ${wgInterface} -j ACCEPT

        # forward rules
        iptables -I FORWARD 1 -i ${wgInterface} -o ${wgInterface} -j ACCEPT
        iptables -I FORWARD 1 -i ${wanInterface} -o ${wgInterface} -j ACCEPT
        iptables -I FORWARD 1 -i ${wgInterface} -o ${wanInterface} -j ACCEPT
      '';
    };

    wireguard.interfaces.${wgInterface} = {
      ips = [ "10.0.1.1/${toString prefix}" ];
      listenPort = port;
      mtu = 1380; # 1460 (ppp0) - 80
      privateKeyFile = config.sops.secrets."misc/wireguard".path;

      peers = [
        { # cez
          publicKey = "IcMpAs/D0u8O/AcDBPC7pFUYSeFQXQpTqHpGOeVpjS8=";
          allowedIPs = [ "10.0.1.2/32" ];
        }
        { # veu
          publicKey = "bJ9aqGYD2Jh4MtWIL7q3XxVHFuUdwGJwO8p7H3nNPj8=";
          allowedIPs = [ "10.0.1.3/32" ];
        }
      ];
    };
  };

  services.dnsmasq.settings = {
    no-dhcp-interface = wgInterface;
    interface = [ wgInterface  ];
  };
}
