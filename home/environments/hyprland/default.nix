{ pkgs
, config
, inputs
, ...
}:

let
  my-python-packages = ps: with ps; [
    (
      buildPythonPackage rec {
        pname = "pyprland";
        version = "1.4.0";
        format = "pyproject";
        src = pkgs.fetchFromGitHub {
          owner = "hyprland-community";
          repo = pname;
          rev = version;
          hash = "sha256-OcL5Yp+gfRSGfmvLiA/M6nIRj+Vm0TxTX88EWLX9iPM=";
        };
        doCheck = false;
        nativeBuildInputs = [
          # Specify dependencies
          poetry-core
        ];
      }
    )
  ];

in

{

  home.file.".config/hypr/hyprland.conf".source = ./config;
  home.file.".wallpaper.jpg".source = ../../../wallpapers/current_wallpaper.jpg;
  home.file.".config/mako".source = ./mako_config;
  home.file.".config/hypr/pyprland.json".source = ./pyprland.json;

  home.packages = with pkgs; [
    # App launcher
    rofi-wayland-unwrapped
    # Network applet
    networkmanagerapplet

    # Screenshot / screen record
    kooha
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

    brightnessctl
    lxappearance

    xwaylandvideobridge

    # Pyprland
    (python310.withPackages my-python-packages)

    # Audio visualizer
    cavalier
  ];

  # Enable bluetooth buttons support
  systemd.user.services.mpris-proxy = {
    Unit.Description = "Mpris proxy";
    Unit.After = [ "network.target" "sound.target" ];
    Service.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    Install.WantedBy = [ "default.target" ];
  };



}
