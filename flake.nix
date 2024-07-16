{
  description = "sinan's reproducible nixos systems";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:sinanmohd/home-manager/sway-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops-nix, home-manager }: let
    lib = nixpkgs.lib;

    makeGlobalImports = host: [
      ./global/common
    ] ++ lib.optional (builtins.pathExists ./global/${host})
      ./global/${host};

    makeNixos = host: system: lib.nixosSystem {
      inherit system;
      modules = [
        sops-nix.nixosModules.sops

        ./os/${host}/configuration.nix
        {
          networking.hostName = host;
          nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
        }

        home-manager.nixosModules.home-manager
        ({ config, ... }: let
          username = config.global.userdata.name;
        in {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = { ... }: {
              imports = [
                ./home/${host}/home.nix
              ] ++ (makeGlobalImports host);
            };
          };
        })
      ] ++ (makeGlobalImports host);
    };

    makeHome = host: system: home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
        ./home/${host}/home.nix
      ] ++ (makeGlobalImports host);
    };
  in
  {
    nixosConfigurations =
      lib.genAttrs [ "cez" "kay" "lia" "fscusat" "dspace" ]
      (host: makeNixos host "x86_64-linux");

    homeConfigurations =
      lib.genAttrs [ "common" "wayland" "pc" "cez" ]
      (host: makeHome host "x86_64-linux");
  };
}
