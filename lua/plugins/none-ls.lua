return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
      },
    })
    local actions = require("neovim-idea.actions")
    vim.keymap.set("n", "<leader>gf", actions.lsp_format_buffer, { desc = "format current buffer" })
  end,
}
