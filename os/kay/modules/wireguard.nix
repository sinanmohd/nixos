{ config, ... }: let
  wgInterface = "wg";
  wanInterface = "ppp0";
  subnet = "10.0.1.0";
  prefix = 24;
  port = 51820;
in {
  sops.secrets."misc/wireguard" = {};

  networking = {
    nat = {
      enable = true;
      externalInterface = wanInterface;
      internalInterfaces = [ wgInterface ];
    };
    firewall = {
      allowedUDPPorts = [ port ];
      extraCommands = ''
        iptables -t nat -I POSTROUTING 1 \
            -s ${subnet}/${toString prefix} \
            -o ${wanInterface} \
            -j MASQUERADE
      '';
    };

    wireguard.interfaces.${wgInterface} = {
      ips = [ "10.0.1.1/${toString prefix}" ];
      listenPort = port;
      mtu = 1412; # 1492 (ppp0) - 80
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
        { # dad
          publicKey = "q70IyOS2IpubIRWqo5sL3SeEjtUy2V/PT8yqVExiHTQ=";
          allowedIPs = [ "10.0.1.4/32" ];
        }
        { # shambai
          publicKey = "YYDlp/bNKkqFHAhdgaZ2SSEMnIjKTqPTK7Ju6O9/1gY=";
          allowedIPs = [ "10.0.1.5/32" ];
        }
      ];
    };
  };

  services.dnsmasq.settings = {
    no-dhcp-interface = wgInterface;
    interface = [ wgInterface  ];
  };

  services.prometheus.exporters.wireguard = {
    enable = true;
    withRemoteIp = true;
    listenAddress = "127.0.0.1";
  };
}
