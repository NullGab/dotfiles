{
  description = "Gabriel's NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # or your current branch

      home-manager = {
        url = "github:nix-community/home-manager/master";
        inputs.nixpkgs.follows = "nixpkgs";
      };

# 1. Add the nix-flatpak input
    nix-flatpak.url = "github:gmodena/nix-flatpak"; 
  };

  outputs = { self, nixpkgs, home-manager, nix-flatpak, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };

        modules = [
          ./hardware-configuration.nix
            ./configuration.nix

# 2. Add the flatpak module to your system
            nix-flatpak.nixosModules.nix-flatpak

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.gabriel = import ./home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
        ];
      };
    };
  };
}
