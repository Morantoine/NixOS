# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # General system settings
      ../../modules/system.nix
      # Containers
      ../../modules/nginx.nix
      # Incluse results of the hardware scan
      ./hardware-configuration.nix
    ];

  sops.defaultSopsFile = ../../secrets/rattlesnake.yaml;

  # Bootloader
  boot.loader = {
    grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = false;
    };
  };

  networking.hostName = "rattlesnake"; # Change your hostname.

  # Enable networking
  networking = {
    interfaces = {
      ens18.ipv4 = {
        addresses = [{
          address = "45.147.97.34";
          prefixLength = 24;
        }];
      };
    };
    defaultGateway = {
      address = "45.147.97.1";
      interface = "ens18";
    };
    nameservers = [ "45.155.168.2" "45.155.168.3" ];
  };

  nix.settings = {
    # Enable flake support
    experimental-features = [ "nix-command" "flakes" ];
    # Optimise store
    auto-optimise-store = true;
  };

  services.syncthing = {
    enable = true;
    user = "antoine";
    dataDir = "/home/antoine";
    configDir = "/home/antoine/.config/syncthing";
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}


