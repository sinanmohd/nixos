{ config, ... }:

let
  inetVlan = 722;
  voipVlan = 1849;
  wanInterface = "enp3s0";
  nameServer = "1.0.0.1";
in
{
  imports = [
    ./router.nix
    ./hurricane.nix
  ];

  sops.secrets = {
    "ppp/chap-secrets" = {};
    "ppp/pap-secrets" = {};
    "ppp/username" = {};
  };

  networking = let
    voipVlanIface = "voip";
  in {
    vlans = {
      wan = {
        id = inetVlan;
        interface = wanInterface;
      };
      ${voipVlanIface} = {
        id = voipVlan;
        interface = wanInterface;
      };
    };

    interfaces = {
      ${voipVlanIface}.useDHCP = true;
      ${wanInterface}.macAddress = "c4:54:44:d5:17:68";
    };

    dhcpcd.extraConfig = ''
      interface ${voipVlanIface}
      ipv4only
      nogateway
    '';
  };

  services = {
    dnsmasq = {
      enable = true;
      settings = {
        server = [ nameServer ];
        bind-interfaces = true;
      };
    };

    pppd = {
      enable = true;

      config = ''
        plugin pppoe.so
        debug

        nic-wan
        defaultroute
        ipv6 ::1,
        noauth

        persist
        lcp-echo-adaptive
        lcp-echo-interval 1
        lcp-echo-failure 5
      '';

      peers.bsnl = {
        enable = true;
        autostart = true;
        configFile = config.sops.secrets."ppp/username".path;
      };

      secret = {
        chap = config.sops.secrets."ppp/chap-secrets".path;
        pap = config.sops.secrets."ppp/pap-secrets".path;
      };
    };
  };
}
