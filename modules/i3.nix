{ pkgs, ... }:


{

  # i3 related options
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  # theming for env-lauched apps
  environment.variables = {
    QT_STYLE_OVERRIDE = "adwaita-dark";
  };

  services.xserver = {
    enable = true;
    updateDbusEnvironment = true;

    # Enable SSH agent on boot
    displayManager.sessionCommands = ''
      			eval $(gnome-keyring-daemon --start)
      			export SSH_AUTH_SOCK
    '';

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
        imagemagick # for blurring the lock screen
        rofi # application launcher, the same as dmenu
        dunst # notification daemon
        networkmanagerapplet # for network
        i3blocks # status bar
        i3lock # default i3 screen locker
        i3status # provide information to i3bar
        i3-gaps # i3 with gaps
        picom # transparency and shadows
        feh # set wallpaper
        acpi # battery information
        arandr # screen layout manager
        xbindkeys # bind keys to commands
        xclip # basic x11 clipboard
        flameshot # full screenshot utility
        xorg.xbacklight # control screen brightness
      ];
    };

    # Configure keymap in X11
    layout = "us";
    xkbVariant = "intl";
  };

  programs.seahorse.enable = true;

}
