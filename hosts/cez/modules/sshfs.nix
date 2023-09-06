{ config, pkgs, ... }:

let
  user = config.userdata.user;
  domain = config.userdata.domain;
in
{
  system.fsPackages = with pkgs; [ sshfs ];

  fileSystems."/kay" = {
    device = "${user}@${domain}:";
    fsType = "sshfs";
    options = [
      "allow_other"         # for non-root access
      "_netdev"             # this is a network fs
      "x-systemd.automount" # mount on demand
      "reconnect"              # handle connection drops
      "ServerAliveInterval=15" # keep connections alive
      "IdentityFile=/var/secrets/ssh/${user}.key"
    ];
  };
}
