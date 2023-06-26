{
  description = "Antoine's Nix/NixOS config";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://cache.nixos.org/"
    ];

    # nix community's cache server
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # A flake is basically a list of inputs/outputs in which inputs are built and sent as arguments to outputs
  inputs = {
    # Official NixOS packages URL
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Home manager for home-scoped config
    home-manager.url = "github:nix-community/home-manager";
    # make Home Manager follow NixPkgs to avoir conflicts
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Spicetify flake for Nix integration
    spicetify-nix.url = github:the-argus/spicetify-nix;
  };

  outputs = inputs@{
      self,
      nixpkgs,
			spicetify-nix,
      home-manager,
      ...
  }: {
    nixosConfigurations = {
      # My hostname, don't forget to change it !
      nixos-antoine = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	# Load configuration
        modules = [
          ./hosts/nixos-antoine

	  # Load Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
		
	    # Change the username !
            home-manager.extraSpecialArgs = inputs;
            home-manager.users.antoine = import ./home;
          }
        ];
      };
      # Add other configurations here if needed...
    };
  };
}
