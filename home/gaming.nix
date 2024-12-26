{ pkgs
, config
, system
, inputs
, ...
}:
# All gaming-related stuff
{
  home.packages = with pkgs; [
    lutris
    wineWowPackages.staging
    winetricks
    # Minecraft
    prismlauncher
  ];
}

