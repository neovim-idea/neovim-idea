local M = {}
--[[
-- NOTE disabled because most likely useless and can be removed

---@brief Shows all code lenses in the current buffer in a selectable list and runs the chosen one.
function M.select_and_run()
  local bufnr = vim.api.nvim_get_current_buf()
  -- Get all code lenses for the current buffer.
  -- The timeout is important for servers that might be slow to respond.
  local lenses = vim.lsp.codelens.get(bufnr, { timeout_ms = 2000 })

  if not lenses or vim.tbl_isempty(lenses) then
    vim.notify("No code lenses found in this buffer.", vim.log.levels.INFO)
    return
  end

  -- Format the lenses into a list of strings for the user to select from.
  local choices = {}
  for i, lens in ipairs(lenses) do
    local command = lens.command
    if command then
      -- Prepend the line number for context.
      local line_nr = lens.range.start.line + 1
      table.insert(choices, string.format("L%d: %s", line_nr, command.title))
    end
  end

  if vim.tbl_isempty(choices) then
    vim.notify("No actionable code lenses found.", vim.log.levels.INFO)
    return
  end

  -- Use Neovim's built-in UI selector.
  vim.ui.select(choices, { prompt = "Select a Code Lens to run:" }, function(choice, index)
    -- The callback is called with nil if the user cancels.
    if not choice or not index then
      vim.notify("Code lens action cancelled.", vim.log.levels.INFO)
      return
    end

    -- Find the original lens object corresponding to the user's choice.
    local selected_lens = lenses[index]
    if selected_lens then
      vim.notify("Running: " .. choice)
      -- vim.lsp.codelens.run() expects a *list* of lenses to execute.
      vim.lsp.codelens.run({ selected_lens })
    end
  end)
end
--]]

return M
