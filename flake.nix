{
  description = "reproducible nixos configuration with flakes";
  inputs.nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      cez = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/cez/configuration.nix ];
      };
      kay = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/kay/configuration.nix ];
      };
    };
  };
}
