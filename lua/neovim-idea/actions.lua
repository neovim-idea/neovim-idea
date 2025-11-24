local Actions = {}

function Actions.insert_line_above_cursor()
  vim.cmd("normal! O")
  vim.defer_fn(function()
    vim.cmd("startinsert!")
  end, 10)
end

function Actions.insert_line_below_cursor()
  vim.cmd("normal! o")
  vim.defer_fn(function()
    vim.cmd("startinsert!")
  end, 10)
end

return Actions
