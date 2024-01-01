{ config, pkgs, ... }:

let
  iface = "hurricane";
  remote = "216.218.221.42";
  address = "2001:470:35:72a::2";
  prefixLength = 64;
in
{
  networking.sits.${iface} = {
    inherit remote;
    ttl = 225;
  };
  networking.interfaces.${iface}.ipv6.addresses = [{
    inherit prefixLength address;
  }];

  sops.secrets = {
    "hurricane/username" = {};
    "hurricane/update_key" = {};
    "hurricane/tunnel_id" = {};
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
