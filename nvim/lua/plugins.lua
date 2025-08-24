return {
	-- Colorscheme
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = true
	},

	-- Dev Icons
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		config = true
	},

	-- Lua Line
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
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
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", 'nvim-tree/nvim-web-devicons' },
		config = function ()
			require("telescope").setup({
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
		end
	},

	-- Treesitter (syntax & parsing)
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	-- Neogit
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},

	-- LSP Config
	{ "neovim/nvim-lspconfig" },

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
		enabled = false
	},
}
