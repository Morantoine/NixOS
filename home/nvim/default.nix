{ config, inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    gnumake
    gcc
    fd
    nodejs
    tree-sitter
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly.override {
      libvterm-neovim = inputs.nixpkgs-staging.legacyPackages.x86_64-linux.libvterm-neovim;
    };
    extraPackages = with pkgs; [
      lua-language-server
      rust-analyzer
    ];
  };

  home.file.".config/nvim/" = {
    source = ./config;
    recursive = true;
  };

}
