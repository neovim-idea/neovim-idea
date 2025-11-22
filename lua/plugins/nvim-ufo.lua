-- keeping this separate from the usual LSP configuration because it seems a bit too much work, to get the
-- `import package.name` folding working ... if it messes too much the LSPs, i might remove it in future releases
return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}
		local language_servers = vim.lsp.get_clients()
		for _, ls in ipairs(language_servers) do
			require("lspconfig")[ls].setup({
				capabilities = capabilities,
			})
		end
		require("ufo").setup({
			open_fold_hl_timeout = 0,
			provider_selector = function(bufnr, filetype, buftype)
				-- Disable UFO completely for Neo-tree or any non-file buffer
				if filetype == "neo-tree" or buftype ~= "" then
					return "" -- no providers
				end
				-- Default providers
				return { "lsp", "indent" }
			end,
		})
	end,
}
