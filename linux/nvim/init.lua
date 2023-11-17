-- paths relative to lua directory
require("keybindings")
require("packages")
require("theme")
-- ~/.config/nvim/lua/config.lua
if vim.loop.os_uname().sysname == "Linux" then
	require("config")
end

-- toggleterm
local toggleterm = require("toggleterm")
toggleterm.setup({
	function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = [[<leader>t]],
	shade_terminals = true,
	persist_size = true,
})

local configs = require("nvim-treesitter.configs")
configs.setup({
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"lua",
		"vim",
		"html",
		"css",
		"java",
		"javascript",
		"json",
		"make",
		"python",
	},
	highlight = {
		enable = true,
	},
	indent = {
		enable = true, -- default is disabled always
	},
})
require("nvim-treesitter.install").compilers = { "clang" }

-- trouble
require("trouble").setup()
-- colorizer
require("colorizer").setup()
-- require('mason').setup()
require("mason").setup()

local masonconfig = require("mason-lspconfig")
masonconfig.setup({
	ensure_installed = { "lua_ls", "html", "cssls", "bashls" },
})

local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "use" },
			},
		},
	},
})

local null_ls = require("null-ls")
local sources = {
	-- null_ls.builtins.formatting.trim_newlines.with({
	-- 	disabled_filetypes = { 'rust' }, -- use rustfmt
	-- }),
	-- null_ls.builtins.formatting.trim_whitespace.with({
	-- 	disabled_filetypes = { 'rust' }, -- use rustfmt
	-- }),
	null_ls.builtins.formatting.stylua, -- lua formatter
	null_ls.builtins.formatting.shfmt, -- shell script formatter, ensure shfmt is installed
	null_ls.builtins.formatting.prettier.with({
		filetypes = { "html", "css", "yaml", "markdown", "json" },
	}),
}
null_ls.setup({ sources = sources })

-- format on save https://www.jvt.me/posts/2022/03/01/neovim-format-on-save/
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

lspconfig.html.setup({})
lspconfig.cssls.setup({})

-- lspconfig.clangd.setup{}

-- coq settings
-- define before require 'coq'
vim.g.coq_settings = {
	auto_start = true,
	clients = {
		third_party = {
			enabled = false,
		},
	},
	display = {
		ghost_text = {
			enabled = false,
		},
	},
	keymap = {
		jump_to_mark = "",
		bigger_preview = "",
	},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

lspconfig.ccls.setup({
	init_options = {
		compilationDatabaseDirectory = "build",
		filetypes = { "c", "cpp", "objc", "objcpp" },
		index = {
			threads = 0,
		},
		clang = {
			excludeArgs = { "-frounding-math" },
		},
	},
	require("coq").lsp_ensure_capabilities({
		capabilities = capabilities,
	}),
})

lspconfig.bashls.setup({})

local telescope = require("telescope")
local actions = require("telescope.actions")
local fb_actions = telescope.extensions.file_browser.actions

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<c-j>"] = actions.move_selection_next,
				["<c-k>"] = actions.move_selection_previous,
			},
		},
		find_files = {},
	},
	extensions = {
		file_browser = {
			theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				i = {
					["<c-j>"] = actions.move_selection_next,
					["<c-k>"] = actions.move_selection_previous,
					["<c-e>"] = fb_actions.create_from_prompt,
				},
				n = {
					["<c-e>"] = fb_actions.create_from_prompt,
				},
			},
		},
	},
})
-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
telescope.load_extension("file_browser")

vim.api.nvim_set_keymap("n", "<leader>o", ":Telescope file_browser<cr>", { noremap = true })
