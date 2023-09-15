{ pkgs, ... }:

let
  signal-desktop = pkgs.signal-desktop.overrideAttrs (oldAttrs: rec {
    preFixup = oldAttrs.preFixup + ''
      				gappsWrapperArgs+=(
      						--add-flags "--use-tray-icon"
      				)
      		'';
  });
  my-python-packages = ps: with ps; [
  (
    buildPythonPackage rec {
      pname = "pyprland";
      version = "1.4.0";
      format = "pyproject";
      src = pkgs.fetchFromGitHub {
        owner = "hyprland-community";
        repo = pname;
        rev = version;
        hash = "sha256-OcL5Yp+gfRSGfmvLiA/M6nIRj+Vm0TxTX88EWLX9iPM=";
      };
      doCheck = false;
      nativeBuildInputs = [
        # Specify dependencies
        poetry-core
      ];
    }
  )
  ];



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
    calibre
    gvfs

    # messaging
    signal-desktop
    telegram-desktop
    discord

    # passwords
    bitwarden
    otpclient
    veracrypt

    # python
    (python310.withPackages my-python-packages)

    # Rust
    rustc
    cargo
    rustfmt

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

  # services = {
  #   # auto mount usb drives
  #   udisks2.enable = true;
  # };



}
