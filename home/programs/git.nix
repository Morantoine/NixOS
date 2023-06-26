{
  pkgs,
  ...
}: {
  home.packages = [pkgs.gh];

  programs.git = {
    enable = true;

    userName = "Morantoine";
    userEmail = "71721545+Morantoine@users.noreply.github.com";
  };
}
