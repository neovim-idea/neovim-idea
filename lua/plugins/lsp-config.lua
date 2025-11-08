return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        on_attach = function(client, _)
          -- make sure to use stylua only for formatting
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })
      vim.lsp.enable("lua_ls")

      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
      })
      vim.lsp.enable("ts_ls")

      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "show symbol information (apidoc)" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to symbol definition" })
      -- go to definition
      vim.keymap.set({ "n", "v" }, "<leader>gd", vim.lsp.buf.definition, { desc = "got to symbol definitio" })
      -- go to references
      vim.keymap.set({ "n", "v" }, "<leader>gr", vim.lsp.buf.references, { desc = "go to symbol references" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "show code action" })
      vim.keymap.set({ "n", "v" }, "<D-r>", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true, desc = "rename symbol" })

      --      -- TODO This will be replaced hopefully by edgy.nvim
      --      vim.g.dapui_open = false
      --      vim.keymap.set("n", "<D-4>", function()
      --        if vim.g.dapui_open == true then
      --          vim.g.dapui_open = false
      --          require("dapui").close({ reset = true })
      --          vim.schedule(function()
      --            vim.cmd("Neotree reveal")
      --          end)
      --        else
      --          vim.g.dapui_open = true
      --          vim.cmd("Neotree close")
      --          vim.schedule(function()
      --            require("dapui").open({ reset = true })
      --          end)
      --        end
      --      end, { desc = "DAP UI toggle" })
    end,
  },
  {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt", "java", "sc" },
    opts = function()
      local metals = require("metals")
      local metals_config = metals.bare_config()
      metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      metals_config.on_attach = function(_, bufnr)
        metals.setup_dap()
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          buffer = bufnr,
          callback = function()
            pcall(vim.lsp.codelens.refresh)
          end,
        })
        pcall(vim.lsp.codelens.refresh)

        vim.keymap.set("n", "<leader>r", vim.lsp.codelens.run, { buffer = bufnr, desc = "Run code lens" })
      end

      local dap = require("dap")
      -- TODO: reorder to make the ui selection pleasant to the eye
      dap.configurations.scala = {
        {
          type = "scala",
          request = "launch",
          name = "[Run] Current file",
          metals = { runType = "run" },
        },
        {
          type = "scala",
          request = "launch",
          name = "[Debug] Current file",
          metals = { runType = "run" },
          dap = {
            request = "launch",
            type = "scala",
            name = "Debug current file",
          },
        },
        {
          type = "scala",
          request = "launch",
          name = "[Run] Current test file",
          metals = { runType = "testFile" },
        },
        {
          type = "scala",
          request = "launch",
          name = "[Debug] Current test file",
          metals = { runType = "testFile" },
          dap = {
            request = "launch",
            type = "scala",
            name = "Debug test current file",
          },
        },
        {
          type = "scala",
          request = "launch",
          name = "[Test] Current project",
          metals = { runType = "testTarget" },
        },
        {
          type = "scala",
          request = "launch",
          name = "[Debug] Current project",
          metals = { runType = "testTarget" },
          dap = {
            request = "launch",
            type = "scala",
            name = "Debug test current target",
          },
        },
      }
      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end,
  },
  {
    "stevearc/dressing.nvim",
    lazy = false,
    config = function()
      require("dressing").setup({
        input = {
          insert_only = false,
          override = function(conf)
            -- specific customisation for renaming symbol popup
            if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline():match("^IncRename") then
              conf.title = "Rename symbol..."
            end
            return conf
          end,
        },
      })
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    dependencies = { "stevearc/dressing.nvim" },
    opts = {
      input_buffer_type = "dressing",
    },
    config = function(_, opts)
      require("inc_rename").setup(opts)

      -- TODO: maybe there's a less hackish way? ie set a global variable to keep track fo the mode, and check it after
      --       we're done, in order to restore the previous mode
      vim.keymap.set("i", "<D-r>", function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
        local word = vim.fn.expand("<cword>")

        vim.ui.input({
          -- this is probably not needed, dressing.nvim does that already
          prompt = "Rename Symbol...",
          default = word,
          completion = "word",
        }, function(new_name)
          if new_name and new_name ~= "" then
            vim.cmd("IncRename " .. new_name)
          end
          vim.cmd("startinsert")
        end)
      end, { desc = "Rename symbol" })
    end,
  },
}
