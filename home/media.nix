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
    # ebooks
    calibre
  ];

}
