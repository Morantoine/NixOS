{ pkgs
, ...
}: {
  home.packages = [ pkgs.gh ];

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;

    userName = "Morantoine";
    userEmail = "71721545+Morantoine@users.noreply.github.com";

    aliases = {
      adog = "log --all --decorate --oneline --graph";
    };
  };
}
