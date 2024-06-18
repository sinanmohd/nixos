{ config, pkgs, ... }: let
  username = config.global.userdata.name;
in {
  imports = [
    ./modules/git.nix
    ./modules/shell.nix
    ./modules/xdgdirs.nix
    ./modules/mimeapps.nix
  ];

  programs.home-manager.enable = true;
  home = {
    inherit username;
    stateVersion = "24.11";
    homeDirectory = "/home/${config.home.username}";

    packages = with pkgs; [
      unzip
      htop
      curl
      file
      nnn
      ps_mem

      dig
      tcpdump
      mtr
      geoipWithDatabase
    ];
  };
}
