{
  description = "sinan's reproducible nixos systems";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops-nix }: let
    lib = nixpkgs.lib;

    makeHost = host: system: lib.nixosSystem {
      inherit system;
      modules = [
        { networking.hostName = host; }
        ./hosts/${host}/configuration.nix
        sops-nix.nixosModules.sops
      ];
    };

    makeX86 = hosts: lib.genAttrs hosts (
        host: makeHost host "x86_64-linux"
    );
  in
  {
    nixosConfigurations = makeX86 [ "cez" "kay" "fscusat" "dspace" ];
  };
}
