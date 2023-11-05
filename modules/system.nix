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
    sops
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

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };


  # Change user and set a password !
  users.users.antoine = {
    isNormalUser = true;
    description = "antoine";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDEs2949hxknStRXLEexRKC3Qwc/baEnEDEAlddUgw08FI7TC1FuU1c+bSOHopS25G0MFPqYVdYU1VKMfAC7W7/yPaOl3vaM4nrJVSipFKtaaPrWsHRwzNNdpeoYnh/SH23AT2kSF7oI2vYT7r2EONVzWO6F33LUk+5iRu9IY+p2AjWlXE4lpelTq3TpHKS8jiifuTJgfLltPUx7pBveNZOZWTc5DNu0hojS36ckR2cOii3vLzKhFeslbz5jxHaVieZgE09TvGJlhsk8Y9MKlAGs9IHrX4XuJPoCRGkNHDYNmGicQBJu7jaSRvwQNZxRG3PnsQ/UbUaTrW4OnHR5LcA61ZV9JZE4iDVvIjcWKiJpwO5GG7uy9wwjaOfSOLshi02g6D03nD+kOmp1qSDqhX+XXEgVvgvKNxbxtTk6RkbJqevuaRXwac1+P2A/2sB/S4IRcCjiyTwIRSr8nshFgWU+wl8LMmyUUXRxFYzhGfI05/PKuPZnPpyllzMvrI+pK/NV2nVjp34dY+coV+R8K5CqRjJNKVQlLrfqfqjw2erbdZCnHtNn1zsKBxT7WMTZApDWTxAE2XyTTLpsDhzDRm7an9Hje86UsK7CR+fueFBdjIitykxWBKWByHwFEaa3DQi0LysfaUbnHOUk0vwETFQKbF96yWOLdKuC0Az7n6oHw== (none)" 
    ];
  };

  # Auto-cleaning
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

}
