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
    TERMINAL = "kitty";
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND = "fg=green,bold";
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND = "fg=red,bold";
  };

}
