{
  description = "sinan's reproducible nixos systems";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    headplane = {
      url = "github:tale/headplane";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:sinanmohd/home-manager/sway-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alina = {
      url = "github:sinanmohd/alina";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    namescale = {
      url = "github:sinanmohd/namescale";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      sops-nix,
      home-manager,
      nixos-hardware,
      alina,
      determinate,
      headplane,
      namescale,
    }:
    let
      lib = nixpkgs.lib;

      makeNixos =
        host: system:
        lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit alina;
            inherit namescale;
            inherit headplane;
            inherit determinate;
            inherit nixos-hardware;
          };

          modules = [
            self.nixosModules.common
            ./os/${host}/configuration.nix
          ];
        };

      makeHome =
        host: system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home/common/home.nix
          ]
          ++ lib.optional (builtins.pathExists ./home/${host}) ./home/${host}/home.nix;
        };
    in
    {
      nixosModules = lib.genAttrs [ "common" "server" "pc" ] (host: {
        nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
        imports = [
          ./os/${host}/configuration.nix
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
        ];
      });

      nixosConfigurations = lib.genAttrs [
        "common"
        "server"
        "pc"
        "cez"
        "kay"
        "lia"
        "fscusat"
      ] (host: makeNixos host "x86_64-linux");

      homeConfigurations = lib.genAttrs [ "common" "wayland" "pc" "cez" ] (
        host: makeHome host "x86_64-linux"
      );
    };
}
