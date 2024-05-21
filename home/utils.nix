{ pkgs, ... }:

{

  home.packages = with pkgs; [
    # archives
    zip
    unzip

    # utils
    ripgrep
    ranger
    xdragon
    evince
    vlc
    neofetch
    tty-clock
    btop
    vis

    # misc
    xdg-utils
    graphviz
    nodejs
    emote

    qbittorrent
    filezilla
  ];

  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
    };
  };

}
