{
  pkgs,
  config,
  ...
}: {
  # Automatically link Picom config
  home.file.".config/picom/picom.conf".source = ./picom.conf;
}
