{ config, ... }:

let
  storage = "/hdd/users";
  user = config.userdata.user;
  pubKeys = config.users.users.${user}.openssh.authorizedKeys.keys;
in
{
  users = {
    groups."sftp".members = [];

    users."sftp" = {
      group = "sftp";
      shell = "/run/current-system/sw/bin/nologin";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFmA1dyV+o9gfoxlbVG0Y+dn3lVqdFs5fMqfxyNc5/Lr sftp@cez"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDCbgjAfyDNtLNyOS+sfLirYtfEAkGqV54LOwabpWkvf sftp@veu"
      ] ++ pubKeys;
    };

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
