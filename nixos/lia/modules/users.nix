{ pkgs, ... }: {
  users.users."rohit" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];

    packages = with pkgs; [ git htop ];
    openssh.authorizedKeys.keys =
      [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOZcWF1zVyxsCdZ/j+h+RlHZlyhgY2Bky03847bxFNSH rohit@victus" ];
  };
}
