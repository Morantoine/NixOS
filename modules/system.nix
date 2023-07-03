# Basic system configuration

{ config, pkgs, ... }:

{
  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

	# Fonts for system and TWM
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

	# No firwall for now, will switch when real install
  networking.firewall.enable = false;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "yes";         # disable root login
      PasswordAuthentication = false; # disable password login
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
	# Auto-unlock of keyring
	security.pam.services.gdm.enableGnomeKeyring = true;

  services = {
    dbus.packages = [ pkgs.gcr ];

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

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
