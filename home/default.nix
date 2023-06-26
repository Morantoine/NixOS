{ config, pkgs, ... }:

{

  imports = [
    ./i3
    ./picom
    ./programs
    ./rofi
    ./shell
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
    stateVersion = "22.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
