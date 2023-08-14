{
  pkgs,
  config,
  ...
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

		lxappearance
  ];

	gtk = {
  	enable = true;
  	gtk3.extraConfig = {
    	gtk-application-prefer-dark-theme = true;
  	};
  	gtk4.extraConfig = {
    	gtk-application-prefer-dark-theme = true;
  	};
	};
  
	qt = {
    enable = true;
    platformTheme = "gnome";
    style.package = pkgs.adwaita-qt;
    style.name = "adwaita-dark";
  };
  
	dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

	home.pointerCursor = {
		name = "phinger-cursors";
		package = pkgs.phinger-cursors;
		size = 24;
		gtk.enable = true;
	};
}
