{ config, ... }:
let
  user = config.global.userdata.nameFq;
  email = config.global.userdata.email;
in
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        inherit user;
        inherit email;
      };
      color.ui = "auto";
      init.defaultBranch = "master";
    };
  };
}
