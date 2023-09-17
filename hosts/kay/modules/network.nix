{ config, pkgs, ... }:

let
  inetVlan = 722;
  wanInterface = "enp4s0";
  domain = config.userdata.domain;
  nameServer = "1.0.0.1";
in
{
  imports = [
    ./wireguard.nix
    ./router.nix
  ];

  sops.secrets = {
    "ppp/chap-secrets" = {};
    "ppp/pap-secrets" = {};
    "ppp/username" = {};
    "misc/namecheap.com" = {};
  };

  networking = {
    enableIPv6 = false;
    vlans.wan = {
      id = inetVlan;
      interface = wanInterface;
    };
  };

  services = {
    dnsmasq = {
      enable = true;
      settings.server = [ nameServer ];
    };
    pppd = {
      secret = {
        chap = config.sops.secrets."ppp/chap-secrets".path;
        pap = config.sops.secrets."ppp/pap-secrets".path;
      };
      enable = true;
      config = ''
        plugin pppoe.so
        nic-wan
        defaultroute
        noauth
      '';
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
      peers.bsnl = {
        enable = true;
        autostart = true;
        configFile = config.sops.secrets."ppp/username".path;
      };
    };
  };
}
