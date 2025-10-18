return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua.with({
          extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        }),
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "format current buffer" })
  end,
}
