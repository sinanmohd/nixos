{ ... }:
let
  wanInterface = "ppp0";

  gponInterface = "enp3s0";
  gponHost = "192.168.38.1";
  gponPrefix = 24;

  lanInterface = "enp8s0f3u1c2";
  lanBridgeInterface = "lan";
  lanPrefix = 24;
  lanHost = "192.168.43.1";

  lanLeaseRangeStart = "192.168.43.100";
  lanLeaseRangeEnd = "192.168.43.254";
  # lanWapMac = "40:86:cb:d7:40:49";
  # lanWapIp = "192.168.43.2";
in
{
  networking = {
    bridges.${lanBridgeInterface}.interfaces = [ lanInterface ];

    nat = {
      enable = true;
      externalInterface = wanInterface;
      internalInterfaces = [ lanBridgeInterface ];
    };
    interfaces = {
      ${lanBridgeInterface}.ipv4.addresses = [
        {
          address = lanHost;
          prefixLength = lanPrefix;
        }
      ];
      ${gponInterface}.ipv4.addresses = [
        {
          address = gponHost;
          prefixLength = gponPrefix;
        }
      ];
    };
    firewall = {
      allowedUDPPorts = [
        53
        67
      ];
      allowedTCPPorts = [ 53 ];
      extraCommands = ''
        iptables -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN \
            -o ${wanInterface} \
            -j TCPMSS --clamp-mss-to-pmtu
      '';
      extraStopCommands = ''
        iptables -t mangle -D FORWARD -p tcp --tcp-flags SYN,RST SYN \
            -o ${wanInterface} \
            -j TCPMSS --clamp-mss-to-pmtu
      '';
    };
  };

  services = {
    kea.dhcp4 = {
      enable = true;
      settings = {
        interfaces-config.interfaces = [ lanBridgeInterface ];
        lease-database = {
          persist = true;
          type = "memfile";
          name = "/var/lib/kea/dhcp4.leases";
        };
        subnet4 = [
          {
            id = 1;
            pools = [
              {
                pool = "${lanLeaseRangeStart} - ${lanLeaseRangeEnd}";
              }
            ];
            subnet = "${lanHost}/${toString lanPrefix}";
          }
        ];
        rebind-timer = 2000;
        renew-timer = 1000;
        valid-lifetime = 4000;
      };
    };

    resolved = {
      enable = true;
      settings.Resolve.DNSStubListenerExtra = lanHost;
    };
  };
}
