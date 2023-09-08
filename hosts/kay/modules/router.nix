{ ... }:

let
  lanInterface = "enp4s0";
  wanInterface = "ppp0";
  subnet = "10.0.0.0";
  prefix = 24;
  host = "10.0.0.1";
  leaseRangeStart = "10.0.0.100";
  leaseRangeEnd = "10.0.0.240";
in
{
  networking = {
    nat.enable = true;
    useDHCP = false;
    interfaces."${lanInterface}" = {
      ipv4.addresses = [{ 
        address = host;
        prefixLength  = prefix;
      }];
    };
    firewall = {
      extraCommands = ''
        # nat datagrams comming through lanInterface to wanInterface
        iptables -t nat -I POSTROUTING 1 -s ${subnet}/${toString prefix} -o ${wanInterface} -j MASQUERADE

        # allow all traffic on lanInterface interface
        iptables -I INPUT 1 -i ${lanInterface} -j ACCEPT

        # forward rules
        iptables -I FORWARD 1 -i ${lanInterface} -o ${lanInterface} -j ACCEPT
        iptables -I FORWARD 1 -i ${wanInterface} -o ${lanInterface} -j ACCEPT
        iptables -I FORWARD 1 -i ${lanInterface} -o ${wanInterface} -j ACCEPT
      '';
    };
  };

  services.dnsmasq.settings = {
    dhcp-range = [ "${leaseRangeStart},${leaseRangeEnd}" ];
    interface = lanInterface;
  };
}
