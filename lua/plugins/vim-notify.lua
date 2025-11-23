-- pretty popups, why not :)
return {
  "rcarriga/nvim-notify",
  lazy = false,
  priority = 1000,
  config = function(_, opts)
    local notify = require("notify")
    notify.setup(require("neovim-idea.options").get_vim_notify_options())
    vim.notify = notify

    local show_all_notifications = function()
      require("telescope").extensions.notify.notify()
    end

    vim.keymap.set("n", "<leader>un", show_all_notifications, { desc = "Show notifications" })

    --[[ NOTE:
    --    this is all due to the fact that neovim-metals, when it loads a project, prints these lines
    --          LSP[metals][Info] Indexing complete!
    --          Press ENTER or type command to continue
    --    which is very annoying because it might get 20-40 seconds to load the whole codebase, meaning that you might
    --    be already typing into a file and, surprise!, the focus is now gone to the command prompt at the bottom :-/
    --    So now we detect the messages that the LSP wants to print, and redirect them in a nice, autohiding popup 
    --]]
    local lsp_level = {
      [1] = vim.log.levels.ERROR,
      [2] = vim.log.levels.WARN,
      [3] = vim.log.levels.INFO,
      [4] = vim.log.levels.DEBUG,
    }

    vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      vim.notify(result.message, lsp_level[result.type], {
        title = ("LSP[%s]"):format(client and client.name or "unknown"),
        render = opts.render,
        timeout = opts.timeout,
      })
    end

    vim.lsp.handlers["window/logMessage"] = function(_, result, ctx)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      vim.notify(result.message, lsp_level[result.type], {
        title = ("LSP[%s]"):format(client and client.name or "unknown"),
        render = opts.render,
        timeout = opts.timeout,
      })
    end
  end,
}
