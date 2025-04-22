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
        iptables -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN \
            -o ${wanInterface} \
            -j TCPMSS --clamp-mss-to-pmtu

        iptables -N inetfilter
        iptables -A inetfilter -s 192.168.43.124/32 -m mac --mac-source 08:02:3c:d4:d9:f2 -j ACCEPT
        iptables -A inetfilter -s 192.168.43.119/32 -m mac --mac-source a8:93:4a:50:c8:b3 -j ACCEPT
        iptables -A inetfilter -j DROP
        iptables -I FORWARD -i lan -o ppp0 -j inetfilter
      '';
      extraStopCommands = ''
        iptables -t mangle -D FORWARD -p tcp --tcp-flags SYN,RST SYN \
            -o ${wanInterface} \
            -j TCPMSS --clamp-mss-to-pmtu

        iptables -w -t filter -F inetfilter
        iptables -w -t filter -X inetfilter
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
