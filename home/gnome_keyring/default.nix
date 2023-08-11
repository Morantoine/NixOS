{
  pkgs,
  config,
  ...
}: {

	home.file.".config/ssh-auto-sock.sh".source = ./gnome_keyring.sh;

}
