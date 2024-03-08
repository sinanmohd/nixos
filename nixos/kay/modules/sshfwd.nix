{ ... }: let
  group = "sshfwd";
in {
  networking.firewall.allowedTCPPorts = [ 2222 ];

  users = {
    groups.${group}.members = [];

    users."lia" = {
      inherit group;
      isSystemUser = true;

      openssh.authorizedKeys.keys
        = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAe7fJlh9L+9JSq0+hK7jNZjszmZqNXwzqcZ+zx0yJyU lia" ];
    };
  };

  services.openssh.extraConfig  = ''
    Match Group ${group}
    ForceCommand echo 'this account is only usable for remote forwarding'
    PermitTunnel no
    AllowAgentForwarding no
    X11Forwarding no

    AllowTcpForwarding remote
    GatewayPorts clientspecified
    PermitListen *:2222
  '';
}
