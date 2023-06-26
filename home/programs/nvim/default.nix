{ config, pkgs, ... }:

{

  programs.neovim = {
  enable = true;
    extraPackages = with pkgs; [
      # Optional dependency for telescope
      gnumake
      fd
      nodejs
    ];
  };

  home.file.".config/nvim/" = {
    source = ./config;
    recursive = true;
  };

}
