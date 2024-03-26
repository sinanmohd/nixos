{
  description = "sinan's reproducible nixos systems";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops-nix, home-manager }: let
    lib = nixpkgs.lib;

    makeNixos = host: system: lib.nixosSystem {
      inherit system;
      modules = [
        {
          networking.hostName = host;
          nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
        }

        ./userdata.nix
        ./nixos/${host}/configuration.nix
        sops-nix.nixosModules.sops
      ];
    };

    makeHome = useType: system: home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
        ./userdata.nix
        ./home-manager/${useType}/home.nix
      ];
    };
  in
  {
    nixosConfigurations =
      lib.genAttrs [ "cez" "kay" "lia" "fscusat" "dspace" ]
      (host: makeNixos host "x86_64-linux");
    homeConfigurations =
      lib.genAttrs [ "common" "wayland" "cez" ]
      (host: makeHome host "x86_64-linux");
  };
}
