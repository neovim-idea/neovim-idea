local M = {}
--[[
-- NOTE disabled because it can be most likely removed & used telescope with buffers view:Neotree reveal

function M.pick_buffer()
  local items = {}
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(b) and vim.bo[b].buflisted then
      local name = vim.api.nvim_buf_get_name(b)
      local label = string.format("%d  %s", b, (name == "" and "[No Name]" or vim.fn.fnamemodify(name, ":t")))
      table.insert(items, { buf = b, label = label })
    end
  end
  if #items == 0 then return vim.notify("No listed buffers") end

  vim.ui.select(
    items,
    { prompt = "Switch buffer", kind = "buffer", format_item = function(it) return it.label end },
    function(choice)
      if choice and vim.api.nvim_buf_is_valid(choice.buf) then
        vim.api.nvim_set_current_buf(choice.buf)
      end
    end
  )
end
--]]

return M

