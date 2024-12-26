{
  config,
  pkgs,
  lib,
  ...
}:

  let
    gradiencePreset = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/GradienceTeam/Community/next/official/catppuccin-mocha.json";
      hash = "sha256-4/RVQF6irDueswEXWtmn2CCmyN7VQtQPrDAeg45cTPk=";
    };
    gradienceBuild = pkgs.stdenv.mkDerivation {
      name = "gradience-build";
      phases = [
        "buildPhase"
        "installPhase"
      ];
      nativeBuildInputs = [ pkgs.gradience ];
      buildPhase = ''
        shopt -s nullglob
        export HOME=$TMPDIR
        mkdir -p $HOME/.config/presets
        gradience-cli apply -p ${gradiencePreset} --gtk both
      '';
      installPhase = ''
        mkdir -p $out
        cp -r .config/gtk-4.0 $out/
        cp -r .config/gtk-3.0 $out/
      '';
    };

  in

  {
    gtk = {
      enable = true;
      font.name = "Inter:medium";
      catppuccin = {
        enable = false;
        icon.enable = true;
      };
      theme.name = "adw-gtk3-dark";
      theme.package = pkgs.adw-gtk3;

      gtk3 = {
        extraCss = builtins.readFile "${gradienceBuild}/gtk-3.0/gtk.css";
        extraConfig = {
          gtk-application-prefer-dark-theme = 1;
          color-scheme = "prefer-dark";
        };
      };
      gtk4 = {
        extraCss = builtins.readFile "${gradienceBuild}/gtk-4.0/gtk.css";
        extraConfig = {
          gtk-application-prefer-dark-theme = 1;
          color-scheme = "prefer-dark";
        };
      };
    };

    catppuccin.pointerCursor.enable = true;
    home.pointerCursor = {
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style.package = pkgs.adwaita-qt;
      style.name = "adwaita-dark";
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  }
