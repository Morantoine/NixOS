{
  description = "Antoine's Nix/NixOS config";

  nixConfig = {
    extra-experimental-features = [ "nix-command" "flakes" ];
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
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    # Spicetify flake for Nix integration
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Hyprland utils
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , hyprland
    , spicetify-nix
    , home-manager
    , hyprland-contrib
    , ...
    }: {
      nixosConfigurations = {
        # My hostname, don't forget to change it !
        balrog = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          # Load configuration
          modules = [

            # ({ config, pkgs, ... }: {
            #   nixpkgs.overlays = [
            #     (final: prev: {
            #       # Add xwaylandvideobridge to the overlay
            #       xwaylandvideobridge = pkgs.libsForQt5.callPackage ./pkgs/xwaylandvideobridge.nix { };
            #     })
            #   ];
            # })

            ./hosts/balrog

            # Load Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              # Change the username !
              home-manager.extraSpecialArgs = { inherit inputs; };
              # home-manager.extraSpecialArgs = inputs;
              home-manager.users.antoine = import ./hosts/balrog/balrog_home.nix;
            }
          ];
        };
        # Add other configurations here if needed...
      };
    };
}
