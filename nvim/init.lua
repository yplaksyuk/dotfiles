vim.g.mapleader = ','

-- Add lazy.nvim to runtime path
vim.opt.rtp:prepend("~/.dotfiles/nvim/lazy")

-- Load plugins
require("lazy").setup("plugins")
require("lsp")

-- Colorscheme
vim.cmd.colorscheme("gruvbox")

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.updatetime = 300

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false

vim.opt.list = true
vim.opt.listchars = { tab = '→ ', nbsp = '␣', trail = '•', precedes = '«' }

local telescope = require('telescope.builtin')
local neogit = require('neogit')
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<tab>', telescope.buffers, opts)
vim.keymap.set('n', '<esc>', ':noh<cr><esc>', opts)
vim.keymap.set('n', '<s-tab>', ':b#<cr>', opts)
vim.keymap.set('n', '<leader>w', ':only<cr>', opts)
vim.keymap.set('n', '<leader>q', ':bd<cr>', opts)

-- Neogit
vim.keymap.set('n', '<leader>g', neogit.open, opts)

-- LSP Commands
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<leader>?', vim.lsp.buf.hover, opts)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }); end, opts)

-- Diagnostics
vim.keymap.set('n', 'd[', function () vim.diagnostic.jump({ count = 1, float = true }) end, opts)
vim.keymap.set('n', 'd]', function () vim.diagnostic.jump({ count = -1, float = true }) end, opts)
vim.keymap.set('n', 'de', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'dq', vim.diagnostic.setloclist, opts)

vim.keymap.set('n', '<leader>ff', telescope.find_files, opts)
vim.keymap.set('n', '<leader>fg', telescope.live_grep, opts)
vim.keymap.set('n', '<leader>fb', telescope.buffers, opts)
vim.keymap.set('n', '<leader>fh', telescope.help_tags, opts)
vim.keymap.set('n', '<leader>fc', function ()
	telescope.find_files({
		default_text = vim.fn.expand("%:p:h"):gsub("^" .. vim.pesc(vim.fn.getcwd()) .. "/", ""),
		hidden = true
	})
end, opts)
