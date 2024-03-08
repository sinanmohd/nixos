{ config, ... }: let
  userName = config.userdata.userFq;
  userEmail = config.userdata.email;
in {
  programs.git = {
    enable = true;
    inherit userName;
    inherit userEmail;

    extraConfig = {
      color.ui = "auto";
      init.defaultBranch = "master";
    };
  };
}
