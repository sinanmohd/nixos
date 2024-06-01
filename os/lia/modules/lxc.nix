{ pkgs, ... }: let
  container = {
    name = "ubu";
    distro = "ubuntu";
    release = "jammy";
  };

  bridge = "lan";
in {
  virtualisation.lxc.enable = true;

  environment.systemPackages = with pkgs; [ wget ];
  systemd.services."lxc-${container.name}-provision" = {
    description = "auto provision ${container.name} lxc container";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    stopIfChanged = false;

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    path = with pkgs; [ wget lxc util-linux gnutar xz gawk ];
    script = ''
      if ! lxc-ls | grep -q ${container.name}; then
          lxc-create -n ${container.name} -t download  -- \
              --arch amd64 \
              --release ${container.release} \
              --dist ${container.distro}

          sed 's/lxcbr0/${bridge}/g' -i /var/lib/lxc/${container.name}/config
      fi

      lxc-start -n ${container.name}
    '';

    preStop = "lxc-stop  --name ${container.name}";
  };
}
