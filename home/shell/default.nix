{ config, pkgs, ... }: {

  imports = [
    ./zsh.nix
    ./starship.nix
    ./terminals.nix
  ];

  # add environment variables
  home.sessionVariables = {
    # set default applications
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
  };

}
