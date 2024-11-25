{ lib, pkgs, ... }: let
  wanInterface = "ppp0";
  wanMTU = 1492;

  gponInterface = "enp3s0";
  gponHost = "192.168.38.1";
  gponPrefix = 24;

  lanInterface = "enp8s0f3u1";
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
      # TODO: fix it upstream
      # https://github.com/NixOS/nixpkgs/blob/e8c38b73aeb218e27163376a2d617e61a2ad9b59/nixos/modules/services/networking/dhcpcd.nix#L13
      # without this dhcpcd will not run, and if we set it to wanInterface,
      # when pppd(ppp0 iface) exit it'll take out wan vlan iface as well
      ${wanInterface}.useDHCP = true;
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
    dhcp-host = "${wapMac},${wapIp}";
    interface = [ lanInterface ];
  };

  boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = 2;
  networking.dhcpcd = {
    allowInterfaces = [ wanInterface ];
    IPv6rs = false;
    wait = "ipv6";
    extraConfig = ''
      ipv6only
      interface ${wanInterface}
        ipv6rs
        ia_pd 1 ${lanInterface}/0
    '';
  };

  # we start the services using pppd script
  systemd.services = {
    dhcpcd = {
      before = lib.mkForce [];
      wants = lib.mkForce [];
      wantedBy = lib.mkForce [];
    };
    radvd = {
      after = lib.mkForce [];
      requires = lib.mkForce[];
      wantedBy = lib.mkForce [];
    };
  };
  services = {
    pppd.script."ipv6" = {
      runtimeInputs = [ pkgs.systemd pkgs.gnugrep pkgs.iproute2 ];
      text = ''
        systemctl restart dhcpcd.service
        systemctl restart radvd.service
      '';
    };
    radvd = {
      enable = lib.mkForce true;
      config = ''
        interface ${lanInterface} {
          AdvSendAdvert on;
          AdvDefaultPreference high;
          AdvLinkMTU ${toString wanMTU};

          MinRtrAdvInterval 3;
          MaxRtrAdvInterval 6;
          AdvDefaultLifetime 60;

          prefix ::/64 {
            AdvPreferredLifetime 30;
            AdvValidLifetime 60;
          };
        };
      '';
    };
  };
}
