local Keymaps = {}

local a = require("neovim-idea.actions")

local defaults = {
  insert_line_above_cursor = {
    mode = { "n", "i", "v" },
    lhs = "<M-D-CR>",
    action = a.insert_line_above_cursor,
    opts = { silent = true, desc = "Insert blank line above (enter insert mode)" },
  },
  insert_line_below_cursor = {
    mode = { "n", "i", "v" },
    lhs = "<D-CR>",
    action = a.insert_line_below_cursor,
    opts = { silent = true, desc = "Insert blank line below (enter insert mode)" },
  },
  move_line_up = {
    mode = { "n", "i" },
    lhs = "<D-S-Up>",
    action = a.move_line_up,
    opts = { desc = "Move line up" },
  },
  move_line_down = {
    mode = { "n", "i" },
    lhs = "<D-S-Up>",
    action = a.move_line_down,
    opts = { desc = "Move line up" },
  },
}

function Keymaps.setup(opts)
  local merged = {}
  for key, value in pairs(defaults) do
    merged[key] = vim.tbl_deep_extend("force", value, (opts or {})[key] or {})
  end

  for _, mapping in pairs(merged) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.action, mapping.opts)
  end
end

return Keymaps
