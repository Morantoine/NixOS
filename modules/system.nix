# Basic system configuration

{ config, pkgs, ... }:

{
  # Set your time zone.
  time.timeZone = "Europe/France";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # If needed, extra options
  # i18n.extraLocaleSettings = {
  #   LC_MESSAGES = "en_US.UTF-8";
  #   LC_TIME = "de_DE.UTF-8";
  # }

  # Enable CUPS to print documents.
  services.printing.enable = true;
  

  fonts = {
    fonts = with pkgs; [
      # icon fonts
      material-design-icons

      # normal fonts
      hack-font
      noto-fonts-emoji

      # nerdfonts
      (nerdfonts.override { fonts = [ "Hack" ]; })
    ];

    # use fonts specified by user rather than default ones
    enableDefaultFonts = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = [ "DejaVu Sans" ];
      sansSerif = [ "DejaVu Sans" ];
      monospace = [ "DejaVu Sans" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  # zsh needs to be set before changing the default shell
  programs.zsh.enable = true;
  programs.dconf.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "yes";         # disable root login
      PasswordAuthentication = true; # disable password login
    };
    openFirewall = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in base system profile
  environment.systemPackages = with pkgs; [
    vim # Anything but Nano please
    wget
    curl
    git
    sysstat
    # Minimal screen capture tool, used by i3 blur lock to take a screenshot
    # print screen key is also bound to this tool in i3 config
    # Feel free to add something more complete in your DE/WM
    scrot
    neofetch
  ];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.power-profiles-daemon = {
    enable = true;
  };
  security.polkit.enable = true;

  services = {
    dbus.packages = [ pkgs.gcr ];

		geoclue2.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };

  # Change user and set a password !
  users.users.antoine = {
    isNormalUser = true;
    description = "antoine";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    # Change the ssh key !
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3lIDx9z7aXEhtl/BmDaoM47TMFVbQb75IHGYEaS1v6gJIH64ZrtE2iLvekU7P9BJMEuX/fJPyRUxbKVOoA9VbFFM20i8PYCORY2r/AZjsbbkrj0RyOQfgmlgQvB+EyR8Sv/HG9qCy/N2MWILn5Dpx/1EajpXTbEQcjS9ZAdj1uRGraOwZimvlTZyWqUrlfEukhj3f13/rzOF3QRmJutW/51KoDiXCOp0p0VkQTWS5QaEEu2aBdze9JigXmgBOX041UidEM8nGXiAFim82O/03GWWsKIuW0xjvvQ0DHXIZw94xFXOhog9JASo44abhYLI6kCFGrSt7BZpuveOZCVPAXRTXo1bSmBeD7+IYpWAIy+94h9O/eVqIUCmihkdtYic225bDeLdNXq/T1bfmaTKY0+a4xjdjo7FveCKYE4mGFXOb+d8YcSeE8qeGmC+LkV7uxsEuImWCMumLgz4xSCVhDn7gOcVRzxKiv7udxUNZnOvgOGBBNcNSasqFGdF8+gs= antoine@pcantoine"
    ];
  };
}
