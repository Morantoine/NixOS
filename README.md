## ❄️ My NixOS Flake setup ❄️

Entire system managed with a NixOS Flake :
- i3-gaps + picom
- Neovim setup written in Lua
- Custom zsh, Spotify, etc...
- Modularity : possible to describe mutiple hosts (not done yet)

---

### How to install :

- Do a barebone install of NixOS with your prefered method (check the [installation guide](https://nixos.wiki/wiki/NixOS_Installation_Guide)). You need to go at least as far as `nixos-generate-config --root /mnt` to generate the `hardware-configuration.nix` file. Please note that the host in this flake is a UEFI system, please adapt accordingly.

- Clone this repo somewhere in `/mnt`.
- Adapt the following variables to customize the flake to your system :
    - Flake description in `flake.nix`.
    - Hostname in `flake.nix`, `hosts/your_machine/default.nix`.
    - Module name of import in `flake.nix`, which needs to follow previous hostname.
    - Username in `flake.nix`, `modules/system.nix` and `home/default.nix`.
    - Home dir in `home/default.nix`.
    - Git email and username in `/home/programs/git.nix`.
- Overwrite `/mnt/path_to/flake/hosts/hardware-configuration.nix` in the flake with `/etc/hardware-configuration.nix`
- Now all that's left is to install ! Run `nixos-install --impure --flake /path_to/flake/#your_hostname` and enjoy.
