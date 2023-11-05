# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # General system settings
      ../../modules/system.nix
      # Use Hyprland on my laptop !
      ../../modules/hyprland.nix
      # Incluse results of the hardware scan
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = false;
    };
  };

  networking.hostName = "balrog"; # Change your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

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


