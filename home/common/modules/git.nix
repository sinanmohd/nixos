{ config, ... }: let
  userName = config.userdata.nameFq;
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
