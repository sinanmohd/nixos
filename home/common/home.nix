{ config, ... }: let
  username = config.global.userdata.name;
in {
  imports = [
    ./modules/git.nix
    ./modules/mimeapps.nix
  ];

  programs.home-manager.enable = true;

  home = {
    inherit username;
    stateVersion = "24.11";
    homeDirectory = "/home/${config.home.username}";
  };
}
