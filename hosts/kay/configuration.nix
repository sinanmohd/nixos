{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
  ];

  networking.hostName = "kay";
  environment.systemPackages = with pkgs; [ tmux ];
}
