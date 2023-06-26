{config, pkgs, ...}: {

  imports = [
    ./zsh.nix
    ./starship.nix
    ./terminals.nix
  ];

  # add environment variables
  home.sessionVariables = {
    # set default applications
    EDITOR = "vim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

}
