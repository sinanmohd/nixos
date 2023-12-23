{ config, pkgs, ... }:

let
  inetVlan = 722;
  wanInterface = "enp0s20u1";
  nameServer = "1.0.0.1";
  domain = config.userdata.domain;
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
    "misc/namecheap.com" = {};
  };

  networking = {
    vlans.wan = {
      id = inetVlan;
      interface = wanInterface;
    };
    # isp checks this macid during ppp authentication
    interfaces.${wanInterface}.macAddress = "c4:54:44:d5:17:68";
  };

  services = {
    dnsmasq = {
      enable = true;
      settings.server = [ nameServer ];
    };
    pppd = {
      enable = true;
      config = ''
        plugin pppoe.so
        nic-wan
        defaultroute
        persist
        noauth
        debug
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
      script."01-ddns" = {
        runtimeInputs = with pkgs; [ curl coreutils ];
        text = ''
          wan_ip="$4"
          api_key="$(cat ${config.sops.secrets."misc/namecheap.com".path})"
          auth_url="https://dynamicdns.park-your-domain.com/update?host=@&domain=${domain}&password=''${api_key}&ip="

          until curl --silent "$auth_url$wan_ip"; do
              sleep 5
          done
        '';
      };
    };
  };
}
