{ pkgs, inputs, ... }:


{

  hardware = {
    opengl.enable = true;
    nvidia = {
      open = false;
      modesetting.enable = true;
      nvidiaSettings = true;
      forceFullCompositionPipeline = true;
      powerManagement.enable = true;
    };
  };

  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    videoDrivers = [ "nvidia" ];
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
  };

  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    swaybg
    mako
    ags
    libdbusmenu-gtk3
    libnotify
    swaylock
    wl-clipboard
    clipnotify
    wl-clip-persist
    # Pulseaudio to expose pactl
    pulseaudio
    wireplumber
    xwaylandvideobridge
    seahorse
    gnome-bluetooth
    hyprwayland-scanner
  ];

  # Fix locking problem
  security.pam.services.swaylock = { };

  # Keyring
  programs.ssh.startAgent = false;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Automount (for Kindle mostly)
  services.udisks2.enable = true;

  services.pcscd.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

}
