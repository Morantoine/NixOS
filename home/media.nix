{ pkgs
, config
, ...
}:
{

  home.packages = with pkgs; [
    # audio control
    pavucontrol
    playerctl
    pulsemixer
    # images
    imv
    # video
    vlc
    jellyfin-media-player
    # ebooks
    calibre
    ryujinx
    dolphin
    kdePackages.qtwayland
  ];

}
