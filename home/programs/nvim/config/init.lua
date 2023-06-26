-- MY NEOVIM CONFIG --

--> load global config
require("user.settings")
--> setup packer
require("plugins.packer_setup")
--> load configs
require("plugins.config")
--> load keymaps
require("user.keybindings")
