{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./firefox.nix
    ./common.nix
    ./git.nix
    ./media.nix
    ./xdg.nix
    ./nvim
    ./spotify.nix
  ];
}
