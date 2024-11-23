{ ... }: let
  wanInterface = "ppp0";

  gponInterface = "enp3s0";
  gponHost = "192.168.38.2";
  gponPrefix = 24;

  lanInterface = "enp8s0f3u1";
  subnet = "10.0.0.0";
  prefix = 24;
  host = "10.0.0.1";
  leaseRangeStart = "10.0.0.100";
  leaseRangeEnd = "10.0.0.254";
in {
  imports = [
    ./wireguard.nix
    ./iperf3.nix
  ];

  networking = {
    nat = {
      enable = true;
      externalInterface = wanInterface;
      internalInterfaces = [ lanInterface ];
    };
    interfaces = {
      ${lanInterface}.ipv4.addresses = [{
          address = host;
          prefixLength  = prefix;
      }];
      ${gponInterface}.ipv4.addresses = [{
          address = gponHost;
          prefixLength  = gponPrefix;
      }];
    };
    firewall = {
      allowedUDPPorts = [ 53 67 ];
      allowedTCPPorts = [ 53 ];
      extraCommands = ''
        iptables -t nat -I POSTROUTING 1 \
            -s ${subnet}/${toString prefix} \
            -o ${wanInterface} \
            -j MASQUERADE
        iptables -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN \
            -o ${wanInterface} \
            -j TCPMSS --clamp-mss-to-pmtu

        iptables -t nat -I POSTROUTING 1 \
            -s ${subnet}/${toString prefix} \
            -o ${gponInterface} \
            -j MASQUERADE
        iptables -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN \
            -o ${gponInterface} \
            -j TCPMSS --clamp-mss-to-pmtu
      '';
    };
  };

  services.dnsmasq.settings = {
    dhcp-range = [ "${leaseRangeStart},${leaseRangeEnd}" ];
    interface = [ lanInterface ];
  };
}
