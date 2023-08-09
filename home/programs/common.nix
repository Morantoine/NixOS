{pkgs, ...}: {


  home.packages = with pkgs; [
    # archives
    zip
    unzip

    # utils
    ripgrep
    ranger
    gotop

    # misc
    xdg-utils
    graphviz
    nodejs

    # productivity
    obsidian

    # messaging
    signal-desktop
    telegram-desktop
    discord

    # python
		(python310.withPackages(ps: with ps; [
		  python-dbusmock # Music in i3blocks
			pygobject3
		]))

    # Rust
    rustc
    cargo
    rustfmt
    rust-analyzer

  ];

  programs = {

    bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
    };

    ssh.enable = true;
  };

  services = {
    # auto mount usb drives
    udiskie.enable = true;
  };

}
