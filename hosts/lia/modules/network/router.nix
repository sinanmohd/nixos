{ ... }: let
  wanInterface = "enp4s0f2";
  lanInterfaces = [ "enp4s0f1" "enp4s0f3" ];

  prefix = 24;
  subnet = "192.168.1.0";
  host = "192.168.1.1";

  leaseRangeStart = "192.168.1.100";
  leaseRangeEnd = "192.168.1.254";
  nameServer = [ "10.0.0.2" "10.0.0.3" ];
in
{
  networking = {
    bridges."lan".interfaces = lanInterfaces;

    nat = {
      enable = true;
      externalInterface = wanInterface;
      internalInterfaces = [ "lan" ];
    };

    interfaces.lan = {
      ipv4.addresses = [{ 
        address = host;
        prefixLength  = prefix;
      }];
    };

    firewall = {
      allowedUDPPorts = [ 53 67 ];
      allowedTCPPorts = [ 53 ];
      extraCommands = 
        "iptables -t nat -I POSTROUTING 1 -s ${subnet}/${toString prefix} -o ${wanInterface} -j MASQUERADE";
    };
  };

  services.dnsmasq = {
    enable = true;

    settings = {
      server = nameServer;
      dhcp-range = [ "${leaseRangeStart},${leaseRangeEnd}" ];
      interface = [ "lan" ];
    };
  };
}
