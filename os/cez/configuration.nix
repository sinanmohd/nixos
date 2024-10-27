{ ... }: {
  imports = [
    ../pc/configuration.nix
    ./hardware-configuration.nix

    ./modules/specialisation.nix
    ./modules/wireguard.nix
    ./modules/tlp.nix
  ];

  environment.etc."asound.conf".text = ''
    defaults.pcm.card 1
    defaults.ctl.card 1
  '';
  hardware.bluetooth.enable = true;
}
