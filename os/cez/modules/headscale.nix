{ config, pkgs, ... }:
let
  headScaleUrl = "https://headscale.${config.global.userdata.domain}";
  user = config.global.userdata.name;

  exitNode = "kay";
  helper = pkgs.writeShellApplication {
    name = "vpn";
    runtimeInputs = with pkgs; [
      libnotify
      tailscale
      jq
    ];

    text = ''
      note() {
        command -v notify-send >/dev/null &&
          notify-send "󰒒  Headscale" "$1"

        printf "\n%s\n" "$1"
      }

      if [ "$(tailscale status --peers --json | jq ".ExitNodeStatus")" = "null" ]; then
        tailscale set --exit-node=${exitNode} &&
          note "Now routing all traffic through ${exitNode}"
      else
        tailscale set --exit-node= &&
          note "Traffic now uses default route."
      fi
    '';
  };
in
{
  sops.secrets."misc/headscale" = { };
  environment.systemPackages = [ helper ];
  networking.firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];

  services.tailscale = {
    enable = true;
    interfaceName = "headscale";
    openFirewall = true;

    authKeyFile = config.sops.secrets."misc/headscale".path;
    extraUpFlags = [
      "--login-server=${headScaleUrl}"
    ];
    extraSetFlags = [
      "--operator=${user}"
      "--accept-routes=true"
    ];
  };
}
