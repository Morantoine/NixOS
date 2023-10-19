{ pkgs
, config
, inputs
, ...
}: {

  home.file.".config/hypr/hyprland.conf".source = ./config;
  home.file.".wallpaper.jpg".source = ../../wallpapers/current_wallpaper.jpg;
  home.file.".config/mako".source = ./mako_config;
  home.file.".config/hypr/pyprland.json".source = ./pyprland.json;
  # home.file.".gnupg/sshcontrol" = { text = "8AC40E35FFF51709B914D8A2B6F1DE04DD8E839E"; };

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

  gnupg
  ];

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
    enableSshSupport = true;
    sshKeys = ["8AC40E35FFF51709B914D8A2B6F1DE04DD8E839E"];
    
  };


}
