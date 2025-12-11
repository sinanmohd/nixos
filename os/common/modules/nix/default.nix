{
  config,
  pkgs,
  determinate,
  lib,
  ...
}:
let
  user = config.global.userdata.name;

  nixWithFix = determinate.inputs.nix.packages.${pkgs.stdenv.system}.nix-everything.override {
    nix-cli = determinate.inputs.nix.packages.${pkgs.stdenv.system}.nix-cli.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or [ ]) ++ [
        ./nix.patch
      ];
    });
  };
in
{
  nix = {
    package = lib.mkForce nixWithFix;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    settings = {
      auto-optimise-store = true;
      use-xdg-base-directories = true;
      trusted-users = [ user ];

      experimental-features = [
        "flakes"
        "nix-command"
      ];

      substituters = [
        "https://nixbin.sinanmohd.com"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nixbin.sinanmohd.com:dXV3KDPVrm+cGJ2M1ZmTeQJqFGaEapqiVoWHgYDh03k="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
