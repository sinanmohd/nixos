{ config, ... }:

let
  storage = "/hdd/users";
  user = config.global.userdata.name;
  pubKeys = config.users.users.${user}.openssh.authorizedKeys.keys;
in
{
  users = {
    groups."sftp".members = [ ];

    users."sftp" = {
      group = "sftp";
      shell = "/run/current-system/sw/bin/nologin";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFmA1dyV+o9gfoxlbVG0Y+dn3lVqdFs5fMqfxyNc5/Lr sftp@cez"
        # https://github.com/zhanghai/MaterialFiles
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILxKrIaWRACi0oKfJRv6m3uUWKjKNyd9edbbFR5pAONH sftp@paq"
        # samsung files only support PEM, hence RSA key
        # https://r1.community.samsung.com/t5/galaxy-s/unable-to-remotely-connect-to-sftp-server-through-my-files/m-p/16347552/highlight/true#M105871
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCqe7CcXJw+dhXKUVeuj1iGOcV7KhyiJ55PxhGDXfQdu1YS5gi/pBnOk39pL22+QBFZX0trU/JNHpCMZWyFp/Fz9GBxp2LJERHwkANu0lk0PJ7QZdg79YN5lKpWTo2GpA3gHHC555Rm5V5BknwbZwVXWvGhSR93g/2b6AjcSZn4ZUwFF8soSb2EYsRa7blVbBv2njV2SGI9FezfHBF+N3CNOP7kxk63Pilk9NEUQuvYF1tmF7z/zIXbyLNaLT1MJE8KCbayM7E/WZuonSBqFf3fsmQge0La/LveRehQHb503uHNHzlFHXdMMZQrzOAHHyFQUHhYECvhLNDhGJb1KrjZcEiKmqCMmvHCG4JssRdJB5mq6J0g05ZmMrKt0srIT6lginkHy89AKkqt83xHHvXhZEw40zoGcq2rZD1dPN3toNZL/uGaIK0u1eMxFbuVKK3OjMg2UwzaHX1DDZyJdRes5huG/uXTgN7xamUu/TIBOK+WgibJeNf93i3GbsYezTs= sftp@paq"
      ]
      ++ pubKeys;
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

  services.openssh = {
    # support samsing files
    settings = {
      HostKeyAlgorithms = "+ssh-rsa";
      PubkeyAcceptedAlgorithms = "+ssh-rsa";
      Macs = [ "hmac-sha2-256" ];
    };

    # sandboxing
    extraConfig = ''
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
  };
}
