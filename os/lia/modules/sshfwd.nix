{ pkgs, config, ... }:
let
  mkFwdSrv =
    {
      local_port,
      remote_port,
      remote_user,
      remote ? "sinanmohd.com",
      ssh_port ? 22,
      key ? config.sops.secrets."sshfwd/${remote}".path,
    }:
    {
      "sshfwd-${toString local_port}-${remote}:${toString remote_port}" = {
        description = "Forwarding port ${toString local_port} to ${remote}";

        wantedBy = [ "multi-user.target" ];
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
        # restart rather than stop+start this unit to prevent
        # the ssh from dying during switch-to-configuration.
        stopIfChanged = false;

        serviceConfig = {
          ExecStart = ''
            ${pkgs.openssh}/bin/ssh -N ${remote_user}@${remote} -p ${toString ssh_port} \
                -R '[::]:${toString remote_port}:127.0.0.1:${toString local_port}' \
                -o ServerAliveInterval=15 \
                -o ExitOnForwardFailure=yes \
                -i ${key}
          '';

          RestartSec = 3;
          Restart = "always";
        };

      };
    };
in
{
  sops.secrets."sshfwd/sinanmohd.com" = { };
  sops.secrets."sshfwd/lia.sinanmohd.com" = { };

  environment.systemPackages = with pkgs; [ openssh ];
  systemd.services =
    (mkFwdSrv {
      local_port = 22;
      remote_user = "lia";
      remote_port = 2222;
    })
    // (mkFwdSrv {
      local_port = 22;
      remote_port = 22;
      ssh_port = 23;
      remote_user = "root";
      remote = "lia.sinanmohd.com";
    });
}
