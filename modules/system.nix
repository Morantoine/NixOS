# Basic system configuration

{ config, pkgs, ... }:

{
  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Fonts for system and TWM
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons

      # normal fonts
      hack-font
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-extra

      # nerdfonts
      (nerdfonts.override { fonts = [ "Hack" ]; })
    ];

    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    # Do I need this?
    fontconfig.defaultFonts = {
      serif = [ ];
      sansSerif = [ ];
      monospace = [ ];
      emoji = [ ];
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
    killall
    curl
    git
    sysstat
  ];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = false;
    extraConfig = "
  		load-module module-switch-on-connect
		";
  };

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
  };

  # Auto-cleaning
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

}
