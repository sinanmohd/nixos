{ config, pkgs, ... }:

let
  iface = "hurricane";
  remote = "216.218.221.42";
  address = "2001:470:35:72a::2";
  gateway = "2001:470:35:72a::1";
  prefixLength = 64;
  prefix = "2001:470:35:72a::/${toString prefixLength}";
in
{
  networking = {
    sits.${iface} = {
      inherit remote;
      ttl = 225;
    };
    interfaces.${iface} = {
      mtu = 1440; # 1460(ppp0) - 20
      ipv6.addresses =
        [{ inherit prefixLength address; }];
    };

    iproute2 = {
      enable = true;
      rttablesExtraConfig = "200 hurricane";
    };
  };

  sops.secrets = {
    "hurricane/username" = {};
    "hurricane/update_key" = {};
    "hurricane/tunnel_id" = {};
  };

  systemd.services."network-route-${iface}" = {
    description = "Routing configuration of ${iface}";
    wantedBy = [
      "network-setup.service"
      "network.target"
    ];
    before = [ "network-setup.service" ];
    bindsTo = [ "network-addresses-hurricane.service" ];
    after = [ "network-pre.target" "network-addresses-hurricane.service" ];
    # restart rather than stop+start this unit to prevent the
    # network from dying during switch-to-configuration.
    stopIfChanged = false;

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    path = [ pkgs.iproute2 ];
    script = ''
      echo -n "adding route ${prefix}... "

      ip -6 rule add from ${prefix} table hurricane || exit 1
      ip -6 route add default via ${gateway} dev hurricane table hurricane || exit 1
    '';
    preStop = ''
      echo -n "deleting route $prefix... "

      ip -6 route del default via ${gateway} dev hurricane table hurricane || exit 1
      ip -6 rule del from ${prefix} table hurricane || exit 1
    '';
  };


  services.pppd.script."02-${iface}" = {
    runtimeInputs = with pkgs; [ curl coreutils iproute2 ];
    text = ''
      wan_ip="$4"
      username="$(cat ${config.sops.secrets."hurricane/username".path})"
      update_key="$(cat ${config.sops.secrets."hurricane/update_key".path})"
      tunnel_id="$(cat ${config.sops.secrets."hurricane/tunnel_id".path})"

      auth_url="https://$username:$update_key@ipv4.tunnelbroker.net/nic/update?hostname=$tunnel_id"
      until curl --silent "$auth_url"; do
          sleep 5
      done

      while [ ! -e /sys/class/net/${iface} ]; do
        sleep 1 # make sure ${iface} is up
      done

      ip tunnel change ${iface} local "$wan_ip" mode sit
    '';
  };
}
