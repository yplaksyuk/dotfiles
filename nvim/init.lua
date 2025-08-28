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

local showBuffers = function ()
	vim.cmd('ls')
end


require 'plugins' {
	-- Let Paq: https://github.com/savq/paq-nvim
	{
		"savq/paq-nvim";

		config = function ()
			keymap('n', '<leader>pp', ':PaqSync<CR>', { desc = 'Plugins sync' })
			keymap('n', '<leader>pi', ':PaqInstall<CR>', { desc = 'Plugins install' })
			keymap('n', '<leader>pu', ':PaqUpdate<CR>', { desc = 'Plugins update' })
			keymap('n', '<leader>pc', ':PaqClean<CR>', { desc = 'Plugins clean' })
		end
	},

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

	-- Fzf: https://github.com/ibhagwan/fzf-lua
	{
		"ibhagwan/fzf-lua";
		dependencies = { "nvim-tree/nvim-web-devicons" };

		config = function ()
			local fzf = require('fzf-lua')

			fzf.setup {
				winopts = {
					height = 1,
					width = 1,
				}
			}

			showBuffers = fzf.buffers

			keymap('n', '<C-p>', function() fzf.global({ resume = true }) end, { desc = 'Find global' })
			keymap('n', '<leader>ff', fzf.files, { desc = 'Find files' })
			keymap('n', '<leader>fg', fzf.live_grep, { desc = 'Find grep' })
			keymap('n', '<leader>fb', fzf.buffers, { desc = 'Find buffers' })
			keymap("n", "<leader>fm", fzf.keymaps, { desc = 'Show keymaps' })
			keymap('n', '<leader>fh', fzf.helptags, { desc = 'Find Help' })
			keymap("n", "<leader>fd", fzf.diagnostics_document, { desc = 'Buffer diagnostics' })
			keymap("n", "<leader>fD", fzf.diagnostics_workspace, { desc = 'Workspace diagnostics' })
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

	-- Nvim-cmp: https://github.com/hrsh7th/nvim-cmp
	{
		'hrsh7th/nvim-cmp';
		dependencies = {
			'neovim/nvim-lspconfig',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
		};

		config = function ()
			local cmp = require 'cmp'

			cmp.setup {
				snippet = {
					expand = function(args) vim.snippet.expand(args.body) end
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
				}, {
					{ name = 'buffer' },
				})
			}
		end
	},

	-- LSP Config
	{
		"neovim/nvim-lspconfig";

		config = function ()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			vim.lsp.config('lua_ls', {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = {'vim'} }
					}
				}
			})

			vim.lsp.config('ts_ls', {
				capabilities = capabilities,
			})

			vim.lsp.enable('lua_ls')
			vim.lsp.enable('ts_ls')
			vim.lsp.enable('clangd')
			vim.lsp.enable('cmake')

			keymap('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
			keymap('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
			keymap('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
			keymap('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
			--[[
			keymap('n', '<leader>?', vim.lsp.buf.hover, { desc = 'Hover' })
			keymap('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
			keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
			]]--
			--keymap('n', '<leader>f', function() vim.lsp.buf.format({ async = true }); end)
		end
	},
}



-- Generic config
keymap('n', '<esc>', ':noh<cr><esc>', { desc = 'Clean highlighting' })
keymap('n', '<tab>', showBuffers, { desc = 'Show buffers' })
keymap('n', '<s-tab>', ':b#<cr>', { desc = 'Switch to other buffer' })
keymap('n', '<leader>e', ':Explore<cr>', { desc = 'Explore files' })
keymap('n', '<leader>w', ':only<cr>', { desc = 'Only this window' })
keymap('n', '<leader>q', ':bd<cr>', { desc = 'Quit buffer' })


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
