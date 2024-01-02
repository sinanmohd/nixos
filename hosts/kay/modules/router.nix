{ ... }:

let
  lanInterface = "enp0s20u4";
  wanInterface = "ppp0";
  subnet = "10.0.0.0";
  prefix = 24;
  host = "10.0.0.1";
  leaseRangeStart = "10.0.0.100";
  leaseRangeEnd = "10.0.0.254";
in
{
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
    useDHCP = false;
    interfaces."${lanInterface}" = {
      ipv4.addresses = [{ 
        address = host;
        prefixLength  = prefix;
      }];
    };
    firewall = {
      allowedUDPPorts = [ 53 67 ];
      allowedTCPPorts = [ 53 ];
      extraCommands = ''
        iptables -t nat -I POSTROUTING 1 -s ${subnet}/${toString prefix} -o ${wanInterface} -j MASQUERADE
      '';
    };
  };

  services.dnsmasq.settings = {
    dhcp-range = [ "${leaseRangeStart},${leaseRangeEnd}" ];
    interface = [ lanInterface ];
  };
}
