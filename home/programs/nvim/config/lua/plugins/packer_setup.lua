--> Where I manage Packer to install plugins

-- First, update packer if needed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Reload Neovim whenever you save this file
vim.cmd([[
augroup packer_user_config
  autocmd!
  autocmd BufWritePost packer_setup.lua source <afile> | PackerSync
augroup end
]])

-- Add plugins to load
return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- Dracula theme
	use("Mofiqul/dracula.nvim")
	use("kyazdani42/nvim-web-devicons")

	-- LuaLine
	use({
		"nvim-lualine/lualine.nvim",
	})

	--treesitter
	use({ "nvim-treesitter/nvim-treesitter" })

	-- auto-closing
	use("windwp/nvim-autopairs")

	-- Telescope
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
	})
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- Vim-Surround
	use("tpope/vim-surround")

	-- Comment
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
	})

	-- Undo-Tree
	use({
		"jiaoshijie/undotree",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- Autocompletion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-nvim-lsp-signature-help")

	-- Snippets
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- Installing and managing LSP servers and DAPs
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- Configuring LSP servers
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use({ "glepnir/lspsaga.nvim", branch = "main" })
	use("onsails/lspkind.nvim")

	-- Configuring DAPs
	use("mfussenegger/nvim-dap")
	use("jay-babu/mason-nvim-dap.nvim")
	use("rcarriga/nvim-dap-ui")
	use("theHamsta/nvim-dap-virtual-text")

	-- formatting and linting
	use("jose-elias-alvarez/null-ls.nvim")
	use("jayp0521/mason-null-ls.nvim")

	-- git gutter
	use("lewis6991/gitsigns.nvim")

	-- Fugitive for Git
	use("tpope/vim-fugitive")

	-- Sniprun to run code
	use({ "michaelb/sniprun", run = "bash ./install.sh" })

	-- session manager and integration to Telescope
	use({
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Downloads", "/", "/tmp" },
			})
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
