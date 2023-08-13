{config, pkgs, ...}:
with pkgs; let
  patchDesktop = pkg: appName: from: to: lib.hiPrio (pkgs.runCommand "$patched-desktop-entry-for-${appName}" {} ''
    ${coreutils}/bin/mkdir -p $out/share/applications
    ${gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
  '');
in {
  home.packages = [
    signal-desktop
    (patchDesktop signal-desktop "signal-desktop" "^Exec=signal-desktop" "Exec=${signal-desktop}/bin/signal-desktop --use-tray-icon")
  ];
}
