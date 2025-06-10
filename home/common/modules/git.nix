{ config, ... }:
let
  userName = config.global.userdata.nameFq;
  userEmail = config.global.userdata.email;
in
{
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
