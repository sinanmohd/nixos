{ ... }:

let
  storage = "/hdd/users";
in
{
  users = {
    groups."sftp".members = [];

    users."nazer" = {
      group = "sftp";
      shell = "/run/current-system/sw/bin/nologin";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICV09w9Ovk9wk4Bhn/06iOn+Ss8lK3AmQAl8+lXHRycu nazu@pc"
      ];
    };
  };

  services.openssh.extraConfig  = ''
    Match Group sftp
    # chroot dir should be owned by root
    # and sub dirs by %u
    ChrootDirectory ${storage}/%u
    ForceCommand internal-sftp

    PermitTunnel no
    AllowAgentForwarding no
    AllowTcpForwarding no
    X11Forwarding no
  '';
}
