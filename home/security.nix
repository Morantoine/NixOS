{ pkgs, ... }:

{

  home.packages = with pkgs; [
    # passwords
    bitwarden
    otpclient
    veracrypt
  ];

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    enableSshSupport = true;
    sshKeys = [ "8AC40E35FFF51709B914D8A2B6F1DE04DD8E839E" ];
  };


}
