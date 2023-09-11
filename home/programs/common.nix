{ pkgs, ... }:

let
  signal-desktop = pkgs.signal-desktop.overrideAttrs (oldAttrs: rec {
    preFixup = oldAttrs.preFixup + ''
      				gappsWrapperArgs+=(
      						--add-flags "--use-tray-icon"
      				)
      		'';
  });

in
{

  home.packages = with pkgs; [
    # archives
    zip
    unzip

    # utils
    ripgrep
    ranger
    evince
    neofetch
    gotop

    # misc
    xdg-utils
    graphviz
    nodejs
    emote

    # productivity
    obsidian
	notion-app-enhanced

    # messaging
    signal-desktop
    telegram-desktop
    discord

    # passwords
    bitwarden
    otpclient
    veracrypt

    # python
    (python310.withPackages (ps: with ps; [
      python-dbusmock # Music in i3blocks
      pygobject3
    ]))

    # Rust
    rustc
    cargo
    rustfmt
    rust-analyzer

    # latex
    texlive.combined.scheme-full

  ];

  programs = {

    bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
    };

    ssh.enable = true;
  };

  services = {
    # auto mount usb drives
    udiskie.enable = true;
  };



}
