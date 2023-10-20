{ config, pkgs, inputs, ... }:

{

  imports = [
    # Use Hyprland as DE
    ../../home/environments/hyprland
    ../../home/gtk.nix

    # Needed programs
    ../../home/waybar
    ../../home/rofi
    ../../home/messaging.nix
    ../../home/firefox.nix
    ../../home/utils.nix
    ../../home/git.nix
    ../../home/media.nix
    ../../home/xdg.nix
    ../../home/nvim
    ../../home/spotify.nix
    ../../home/gaming.nix
    ../../home/shell
    ../../home/security.nix
    ../../home/ssh.nix
  ];

  # Change your username ! 
  home = {
    username = "antoine";
    homeDirectory = "/home/antoine";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
