require("packer").startup(function()
	use("wbthomason/packer.nvim")
	-- trouble
	use("folke/trouble.nvim")
	-- nvim-colorizer
	use("norcalli/nvim-colorizer.lua")
	-- vim-cmake
	use("cdelledonne/vim-cmake")
	-- floaterm
	-- use 'voldikss/vim-floaterm'
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})
	use("jose-elias-alvarez/null-ls.nvim")
	-- colorscheme / theme
	-- use 'ellisonleao/gruvbox.nvim'
	use("shaunsingh/nord.nvim")
	-- indent-blankline
	use("lukas-reineke/indent-blankline.nvim")
	-- autocompletion plugin
	use({
		"ms-jpq/coq_nvim",
		branch = "coq",
		run = ":COQdeps",
		requires = {
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
			{ "ms-jpq/coq.thirdparty", branch = "3p" },
		},
		disabled = false,
	})

	-- commenter
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	-- autopairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	-- bufferline
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })
	-- statusline
	use("nvim-tree/nvim-web-devicons") -- required by lualine.vim
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	-- vimwiki
	use({
		"vimwiki/vimwiki",
		config = function()
			vim.g.vimwiki_list = {
				{
					path = "~/",
					syntax = "markdown",
					ext = ".md",
				},
			}
			vim.g.vimwiki_ext2syntax = {
				[".md"] = "markdown",
				[".markdown"] = "markdown",
				[".mdown"] = "markdown",
			}
		end,
	})
	-- alpha (startify plugin)
	use({
		"goolord/alpha-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
			local startify = require("alpha.themes.startify")
			startify.section.bottom_buttons.val = {
				startify.button("c", "cheat", ":e ~/.config/nvim/cheat.md <cr>"),
				startify.button("v", "config", ":e ~/.config/nvim/init.lua <cr>"),
				startify.button("q", "quit", ":qa<cr>"),
			}
			vim.api.nvim_set_keymap("n", "<c-n>", ":Alpha<cr>", { noremap = true })
		end,
	})
	-- telescope-fzf-native (as required by telescope)
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})
	use({
		"nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	})
	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		requires = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
	})
	-- nvim-treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use({
		"williamboman/mason.nvim", -- improved version of nvim-lsp-installer
		"williamboman/mason-lspconfig.nvim", -- works with lspconfig for proper mason configuration
		"neovim/nvim-lspconfig",
	})
end)
