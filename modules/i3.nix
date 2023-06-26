{pkgs, ...}:


{

  # i3 related options
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
        defaultSession = "none+i3";
        gdm.enable = true;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi          # application launcher, the same as dmenu
	      dunst         # notification daemon
        i3blocks      # status bar
        i3lock        # default i3 screen locker
        i3status      # provide information to i3bar
        i3-gaps       # i3 with gaps
        picom         # transparency and shadows
        feh           # set wallpaper
        acpi          # battery information
        arandr        # screen layout manager
        xbindkeys     # bind keys to commands
        xorg.xbacklight  # control screen brightness
     ];
    };

    # Configure keymap in X11
    layout = "us";
    xkbVariant = "intl";
  };

}
