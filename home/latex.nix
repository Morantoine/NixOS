{ pkgs, ... }:

{

  home.packages = with pkgs; [
    # latex
    texlive.combined.scheme-full
  ];

}
