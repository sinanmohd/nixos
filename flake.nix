{
  description = "reproducible nixos configuration with flakes";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops-nix }: {
    nixosConfigurations = {
      cez = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/cez/configuration.nix
          sops-nix.nixosModules.sops
        ];
      };
      kay = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/kay/configuration.nix
          sops-nix.nixosModules.sops
        ];
      };
      mox = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/mox/configuration.nix
          sops-nix.nixosModules.sops
        ];
      };
    };
  };
}
