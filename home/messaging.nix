{ pkgs, ... }:

let
  signal-desktop = pkgs.signal-desktop.overrideAttrs (oldAttrs: rec {
    preFixup = oldAttrs.preFixup + ''
      				gappsWrapperArgs+=(
      						--add-flags "--use-tray-icon"
      				)
      		'';
  });
  krisp_patch = pkgs.callPackage ./krisp_patch { };


in
{

  home.packages = with pkgs; [
    # messaging
    signal-desktop
    telegram-desktop
    discord
    krisp_patch
  ];

}
