-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.updatetime = 300
vim.opt.mouse = ''

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false

vim.opt.list = true
vim.opt.listchars = { tab = '→ ', nbsp = '␣', trail = '•', precedes = '«' }

local keymap = function (mode, keys, handler, opts)
	vim.keymap.set(mode, keys, handler, vim.tbl_extend('force', { noremap = true, silent = true }, opts or {}))
end


require 'plugins' {
	-- Let Paq manage itself
	{
		"savq/paq-nvim";

		config = function ()
			keymap('n', '<tab>', ':Telescope buffers<cr>', { desc = 'Show buffers' })
			keymap('n', '<esc>', ':noh<cr><esc>', { desc = 'Clean highlighting' })
			keymap('n', '<s-tab>', ':b#<cr>', { desc = 'Switch to other buffer' })
			keymap('n', '<leader>w', ':only<cr>', { desc = 'Only this window' })
			keymap('n', '<leader>q', ':bd<cr>', { desc = 'Quit buffer' })
		end
	};


	-- Colorscheme
	{
		"ellisonleao/gruvbox.nvim";

		config = function ()
			vim.cmd.colorscheme("gruvbox")
		end
	},

	-- Lua Line
	{
		'nvim-lualine/lualine.nvim';
		dependencies = { 'nvim-tree/nvim-web-devicons' };

		config = function()
			require('lualine').setup({
				options = {
					theme = 'gruvbox',   -- or 'auto'
					section_separators = { left = '', right = '' },
					component_separators = { left = '', right = '' },
					icons_enabled = true,
				},
				sections = {
					lualine_a = { 'mode' },
					lualine_b = { 'branch', 'diff', 'diagnostics' },
					lualine_c = { 'filename' },
					lualine_x = { 'encoding', 'fileformat', 'filetype' },
					lualine_y = { 'progress' },
					lualine_z = { 'location' }
				}
			})
		end
	},

	-- Telescope (fuzzy finder)
	{
		"nvim-telescope/telescope.nvim";
		dependencies = { "nvim-lua/plenary.nvim", 'nvim-tree/nvim-web-devicons' };

		config = function ()
			require("telescope").setup({
				pickers = {
					buffers = {
						sort_lastused = true,     -- sort by most recently used
						ignore_current_buffer = true, -- (optional) hide current buffer
						sort_mru = true,          -- telescope >= 0.1.2: explicit MRU sorting
					},
				},
				defaults = {
					layout_strategy = 'horizontal',
					layout_config = {
						preview_width = 0
					},
					prompt_prefix = "🔍 ",
					selection_caret = " ",
					entry_prefix = "  ",
					file_ignore_patterns = {},
				}
			})

			local telescope = require('telescope.builtin')
			keymap('n', '<leader>ff', telescope.find_files, { desc = 'Find Files' })
			keymap('n', '<leader>fg', telescope.live_grep, { desc = 'Find Grep' })
			keymap('n', '<leader>fb', telescope.buffers, { desc = 'Find Buffers' })
			keymap('n', '<leader>fh', telescope.help_tags, { desc = 'Find Help' })
			keymap('n', '<leader>fc', function ()
				telescope.find_files({
					default_text = vim.fn.expand("%:p:h"):gsub("^" .. vim.pesc(vim.fn.getcwd()) .. "/", ""),
					hidden = true
				}, { desc = 'Find in Current dir' })
			end)
		end
	},

	-- Treesitter (syntax & parsing)
	{
		"nvim-treesitter/nvim-treesitter";
		build = ":TSUpdate";

		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				indent = { enable = true },
			})
		end
	},

	-- Fugitive
	{
		'tpope/vim-fugitive';

		config = function ()
			keymap('n', '<leader>g', ':Git<cr>', { desc = 'Git' })
		end
	},

	-- Which Key
	{
		"folke/which-key.nvim";
		dependencies = { 'echasnovski/mini.nvim' };

		config = function ()
			require('which-key').setup({
				preset = 'helix',
			})

			--[[
			wk.register({
				{ "<leader>b", group = "buffer" },
				{ "<leader>f", group = "file" },
				{ "<leader>g", group = "git" },
			})]]--
		end
	},

	-- LSP Config
	{
		"neovim/nvim-lspconfig";

		config = function ()
			vim.lsp.config('lua_ls', {
				settings = {
					Lua = {
						diagnostics = { globals = {'vim'} }
					}
				}
			})

			vim.lsp.enable('lua_ls')
			vim.lsp.enable('ts_ls')
			vim.lsp.enable('clangd')
			vim.lsp.enable('cmake')

			--[[
			keymap('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
			keymap('n', 'gr', vim.lsp.buf.references, { desc = 'Go to References' })
			keymap('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
			keymap('n', '<leader>?', vim.lsp.buf.hover, { desc = 'Hover' })
			keymap('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
			keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
			]]--
			--keymap('n', '<leader>f', function() vim.lsp.buf.format({ async = true }); end)
		end
	},
}


vim.diagnostic.config({
  virtual_text = true,   -- show inline
  signs = false,          -- show in sign column
  underline = true,      -- underline the text
  update_in_insert = false,
})

-- Diagnostics
keymap('n', ']d', function () vim.diagnostic.jump({ count = 1, float = true }) end, { desc = 'Next Diagnostic' })
keymap('n', '[d', function () vim.diagnostic.jump({ count = -1, float = true }) end, { desc = 'Prev Diagnostic' })
keymap('n', 'de', vim.diagnostic.open_float)
keymap('n', 'dq', vim.diagnostic.setloclist)
