{ config, ... }: let
  user = config.global.userdata.name;
  email = config.global.userdata.email;
in {
  users.users.${user} = {
    uid = 1000;
    isNormalUser = true;
    description = email;
    extraGroups = [ "wheel" ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAcCendbKbeoc7hYEEcBt9wwtSXrJUgJ2SuYARO0zPAX sinan@veu"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL8LnyOuPmtKRqAZeHueNN4kfYvpRQVwCivSTq+SZvDU sinan@cez"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHeyFnYE9RJ87kbkjgrev/yw1Z4PVLxvfPAtJjBMOYPq sinan@ale"
    ];
  };
}
