{ pkgs
, ...
}: {
  home.packages = [ pkgs.gh ];

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;

    userName = "Morantoine";
    userEmail = "antoine.moran@protonmail.com";

    signing = {
      key = "C9BB0E3CE9F8C38ED3CC950D30CE7F957BD7DA57";
      signByDefault = true;
    };

    aliases = {
      adog = "log --all --decorate --oneline --graph";
    };
  };
}
