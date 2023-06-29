{
  pkgs,
  config,
  ...
}: {

  # Automatically copy wallpaper and config files
  home.file.".config/i3/wallpaper.jpg".source = ../../wallpaper.jpg;
  home.file.".config/i3/config".source = ./config;
  home.file.".config/i3/i3blocks.conf".source = ./i3blocks.conf;
  # home.file.".config/i3/keybindings".source = ./keybindings;
  home.file.".config/i3/scripts" = {
    source = ./scripts;
    # copy the scripts directory recursively
    recursive = true;
    executable = true;  # make all scripts executable
  };

	# Theming

	gtk = {
  	enable = true;
  	gtk3.extraConfig = {
    	gtk-application-prefer-dark-theme = true;
  	};
  	gtk4.extraConfig = {
    	gtk-application-prefer-dark-theme = true;
  	};
		# cursorTheme = pkgs.quintom-cursor-theme;
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

	home.sessionVariables.QT_QPA_PLATFORMTHEME = "gnome";

}
