{ ... }: {
  imports = [
    ../pc/configuration.nix
    ./hardware-configuration.nix

    ./modules/wireguard.nix
    ./modules/tlp.nix
  ];

  sound.extraConfig = ''
    defaults.pcm.card 1
    defaults.ctl.card 1
  '';
}
