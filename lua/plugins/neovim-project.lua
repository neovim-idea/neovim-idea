return {
	{
		{
			"nvim-mini/mini.icons",
			version = false,
			config = function()
				require("mini.icons").setup({})
			end,
		},
	},
	{
		"coffebar/neovim-project",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
			{ "Shatur/neovim-session-manager" },
		},
		lazy = false,
		priority = 100,
		init = function()
			vim.opt.sessionoptions:append("globals")
		end,
		config = function()
			require("neovim-project").setup({
				projects = {
					"~/projects/*",
					"~/.config/*",
				},
				picker = {
					type = "telescope",
				},
			})

			vim.keymap.set("n", "<leader>pd", function()
				vim.cmd("NeovimProjectDiscover")
			end, { desc = "Neovim Project: Discover" })
			vim.keymap.set("n", "<leader>ph", function()
				vim.cmd("NeovimProjectHistory")
			end, { desc = "Neovim Project: History" })
		end,
	},
}
