{ config, ... }: let
  username = config.userdata.user;
in {
  imports = [ ./modules/git.nix ];

  programs.home-manager.enable = true;

  home = {
    inherit username;
    stateVersion = "23.11";
    homeDirectory = "/home/${config.home.username}";
  };
}
