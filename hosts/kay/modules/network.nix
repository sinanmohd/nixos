{ config, pkgs, ... }:

let
  inetVlan = 722;
  voipVlan = 1849;
  wanInterface = "enp4s0";
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

    interfaces.${voipVlanIface}.useDHCP = true;
    dhcpcd.extraConfig = ''
      interface ${voipVlanIface}
      ipv4only
      nogateway
    '';
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
              sleep 1
          done
        '';
      };
    };
  };
}
