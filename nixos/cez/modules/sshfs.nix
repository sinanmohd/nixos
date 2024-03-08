{ config, pkgs, ... }:

let
  domain = config.userdata.domain;
  user = config.userdata.name;
  uid = config.users.users.${user}.uid;
  gid = config.users.groups.users.gid;
in
{
  sops.secrets."misc/sftp" = {};
  system.fsPackages = with pkgs; [ sshfs ];

  fileSystems."/media/kay" = {
    device = "sftp@${domain}:";
    fsType = "sshfs";
    options = [
      "allow_other"         # for non-root access
      "uid=${toString uid}"
      "gid=${toString gid}"
      "_netdev"             # this is a network fs
      "x-systemd.automount" # mount on demand
      "reconnect"              # handle connection drops
      "ServerAliveInterval=15" # keep connections alive
      "IdentityFile=${config.sops.secrets."misc/sftp".path}"
    ];
  };
}
