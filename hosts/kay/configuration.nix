{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
  ];

  services.openssh = {
    enable = true;
    settings = { PasswordAuthentication = false; };
  };

  boot.consoleLogLevel = 3;
  networking.hostName = "kay";
  environment.systemPackages = with pkgs; [ tmux ];
}
