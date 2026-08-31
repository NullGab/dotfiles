{
  description = "Gabriel's NixOS Flake Configuration";

inputs = {
    # Change this to nixos-unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      # Change this to master to match the unstable packages
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      # Changed to 'nixos' to match networking.hostName
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        
        # Pass inputs down to modules
        specialArgs = { inherit inputs; };

        modules = [
          # Your standard system configuration files
          ./hardware-configuration.nix
          ./configuration.nix

          # The Home Manager NixOS module
          home-manager.nixosModules.home-manager
          {
            # Tell Home Manager to use the system-level Nixpkgs
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            
            # This line automatically backs up conflicting files (like your old .zshrc)
            home-manager.backupFileExtension = "backup";
            
            # Link your user to the home.nix file
            home-manager.users.gabriel = import ./home.nix;

            # Pass the flake inputs to home.nix just in case you need them there
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
  };
}
