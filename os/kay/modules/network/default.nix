{ config, pkgs, ... }:

let
  inetVlan = 1003;
  wanInterface = "enp3s0";
  nameServer = [
    "1.0.0.1"
    "1.1.1.1"
  ];
in
{
  imports = [
    ./router.nix
    ./hurricane.nix
    ./headscale.nix
  ];

  sops.secrets = {
    "ppp/chap-secrets" = { };
    "ppp/pap-secrets" = { };
    "ppp/username" = { };
  };

  networking = {
    tempAddresses = "disabled";
    vlans.wan = {
      id = inetVlan;
      interface = wanInterface;
    };
  };

  services = {
    dnsmasq = {
      enable = true;
      settings = {
        server = nameServer;
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
        ipv6 ::1337,
        noauth

        persist
        lcp-echo-adaptive
        lcp-echo-interval 1
        lcp-echo-failure 5
      '';

      script."01-ipv6-ra" = {
        type = "ip-up";
        runtimeInputs = [ pkgs.procps ];

        text = ''
          sysctl net.ipv6.conf.ppp0.accept_ra=2
        '';
      };

      peers.keralavision = {
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
