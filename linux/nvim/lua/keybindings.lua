local keymap = vim.api.nvim_set_keymap
vim.g.mapleader = "`"
keymap("n", "<c-s>", ":w<cr>", {})
keymap("i", "<c-s>", "<esc>:w<cr>", {})

local opts = { noremap = true }
keymap("n", "<c-j>", "<c-w>j", opts)
keymap("n", "<c-h>", "<c-w>h", opts)
keymap("n", "<c-k>", "<c-w>k", opts)
keymap("n", "<c-l>", "<c-w>l", opts)
keymap("n", "<c-p>", ":Files<cr>", opts)

-- trouble
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })

-- jump to the next item, skipping the groups
require("trouble").next({ skip_groups = true, jump = true })
-- jump to the previous item, skipping the groups
require("trouble").previous({ skip_groups = true, jump = true })
-- jump to the first item, skipping the groups
require("trouble").first({ skip_groups = true, jump = true })
-- jump to the last item, skipping the groups
require("trouble").last({ skip_groups = true, jump = true })

-- CMake
keymap("", "<leader>cg", ":CMakeGenerate build<cr>", {})
keymap("", "<leader>cb", ":CMakeBuild<cr>", {})
keymap("", "<leader>cq", ":CMakeClose<cr>", {})
keymap("", "<leader>cc", ":CMakeClean<cr>", {})

local function nkeymap(key, map)
	keymap("n", key, map, opts)
end

-- telescope
nkeymap("ff", "<cmd>Telescope find_files<cr><esc>")
nkeymap("fg", "<cmd>Telescope live_grep<cr>")
nkeymap("fb", "<cmd>Telescope buffers<cr>")
nkeymap("fh", "<cmd>Telescope help_tags<cr>")

-- lsp
nkeymap("gd", ":lua vim.lsp.buf.definition()<cr>")
nkeymap("gD", ":lua vim.lsp.buf.declaration()<cr>")
nkeymap("gi", ":lua vim.lsp.buf.implementation()<cr>")
nkeymap("gw", ":lua vim.lsp.buf.document_symbol()<cr>")
nkeymap("gw", ":lua vim.lsp.buf.workspace_symbol()<cr>")
nkeymap("gr", ":lua vim.lsp.buf.references()<cr>")
nkeymap("gt", ":lua vim.lsp.buf.type_definition()<cr>")
nkeymap("K", ":lua vim.lsp.buf.hover()<cr>")
-- nkeymap('<c-k>', ':lua vim.lsp.buf.signature_help()<cr>')
nkeymap("<leader>af", ":lua vim.lsp.buf.code_action()<cr>")
nkeymap("<leader>rn", ":lua vim.lsp.buf.rename()<cr>")
