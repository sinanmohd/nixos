{ pkgs, config, ... }: {
  sops.secrets."sshfwd/kay" = {};

  environment.systemPackages = with pkgs; [ openssh ];
  systemd.services."sshfwd" = {
    description = "Forwarding port 22 to the Internet";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    # restart rather than stop+start this unit to prevent the
    # network from dying during switch-to-configuration.
    stopIfChanged = false;

    path = [ pkgs.openssh ];
    script = ''
      echo -n "Forwarding port 22"
      exec ssh -N lia@sinanmohd.com \
          -R 0.0.0.0:2222:127.0.0.1:22 \
          -i ${config.sops.secrets."sshfwd/kay".path}
    '';
  };
}
