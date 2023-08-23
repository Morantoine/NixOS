{ pkgs, ... }:

# terminal config

let
  font = "Hack Nerd Font";
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        # Add padding for WM
        padding = {
          x = 10;
          y = 10;
        };
        opacity = 0.95;
      };
      font = {
        normal.family = font;
        bold.family = font;
        italic.family = font;
        size = 11;
      };
      import = [ pkgs.alacritty-theme.dracula ];
    };
  };
}
