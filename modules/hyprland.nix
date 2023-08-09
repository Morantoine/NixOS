{pkgs, ...}:


{

	hardware = {
		opengl.enable = true;
		nvidia.modesetting.enable = true;
	};

  services.xserver = {
  		enable = true;
		displayManager.gdm = {
			enable = true;
			wayland = true;
		};
	};

	programs.hyprland = {
			enable = true;
			xwayland.enable = true;
			nvidiaPatches = true;
	};

	programs.waybar = {
		enable = true;
		package = pkgs.waybar.overrideAttrs (oldAttrs: {
			 mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
		});
	};

  environment.systemPackages = with pkgs; [
		swww
		swaybg
  ];

	# Keyring
	services.gnome.gnome-keyring.enable = true;
	programs.seahorse.enable = true;
	
}
