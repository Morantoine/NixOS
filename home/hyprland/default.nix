{ pkgs
, config
, inputs
, ...
}: {

  home.file.".config/hypr/hyprland.conf".source = ./config;
  home.file.".wallpaper.jpg".source = ../../wallpaper.jpg;
  home.file.".config/mako".source = ./mako_config;

  home.packages = with pkgs; [
    # App launcher
    rofi-wayland-unwrapped
    # Network applet
    networkmanagerapplet

    # Screenshot / screen record
    grim
    slurp
    kooha
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

    brightnessctl
    lxappearance

	# Gaming
	prismlauncher
	
  ];

}
