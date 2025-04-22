{ ... }: let
  wanInterface = "ppp0";

  gponInterface = "enp3s0";
  gponHost = "192.168.38.1";
  gponPrefix = 24;

  lanInterface = "enp8s0f3u1c2";
  bridgeInterface = "lan";
  subnet = "192.168.43.0";
  prefix = 24;
  host = "192.168.43.1";
  leaseRangeStart = "192.168.43.100";
  leaseRangeEnd = "192.168.43.254";

  wapMac = "40:86:cb:d7:40:49";
  wapIp = "192.168.43.2";
in {
  imports = [
    ./wireguard.nix
    ./iperf3.nix
  ];

  networking = {
    bridges.${bridgeInterface}.interfaces = [ lanInterface ];

    nat = {
      enable = true;
      externalInterface = wanInterface;
      internalInterfaces = [ bridgeInterface ];
    };
    interfaces = {
      ${bridgeInterface}.ipv4.addresses = [{
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
      '';
    };
  };

  services.dnsmasq.settings = {
    dhcp-range = [ "${leaseRangeStart},${leaseRangeEnd}" ];
    dhcp-host= "${wapMac},${wapIp}";
    interface = [ bridgeInterface ];
  };

  services.prometheus.exporters.dnsmasq = {
    enable = true;
    listenAddress = "127.0.0.1";
  };
}
