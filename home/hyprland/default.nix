{ pkgs
, config
, inputs
, ...
}: {

  home.file.".config/hypr/hyprland.conf".source = ./config;
  home.file.".wallpaper.jpg".source = ../../wallpapers/current_wallpaper.jpg;
  home.file.".config/mako".source = ./mako_config;
  home.file.".config/hypr/pyprland.json".source = ./pyprland.json;

  home.packages = with pkgs; [
    # App launcher
    rofi-wayland-unwrapped
    # Network applet
    networkmanagerapplet

    # Screenshot / screen record
    kooha
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

    brightnessctl
    lxappearance

	# Gaming
	prismlauncher
	qbittorrent

	# Set red color at night
	wlsunset
  ];

}
