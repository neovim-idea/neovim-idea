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
    lhs = "<M-S-Up>",
    action = a.move_line_up,
    opts = { silent = true, desc = "Move line up" },
  },
  move_line_down = {
    mode = { "n", "i" },
    lhs = "<M-S-Down>",
    action = a.move_line_down,
    opts = { silent = true, desc = "Move line up" },
  },
  smart_cut = {
    mode = { "n", "i", "v" },
    lhs = "<D-x>",
    action = a.smart_cut,
    opts = { noremap = true, silent = true, desc = "Cut text" },
  },
  smart_copy = {
    mode = { "n", "i", "v" },
    lhs = "<D-c>",
    action = a.smart_copy,
    opts = { noremap = true, silent = true, desc = "Copy text" },
  },
  smart_paste = {
    mode = { "n", "i", "v" },
    lhs = "<D-v>",
    action = a.smart_paste,
    opts = { noremap = true, silent = true, desc = "Paste text" },
  },
  undo = {
    mode = { "n", "i", "v", "x", "s" },
    lhs = "<D-z>",
    action = a.undo,
    opts = { expr = true, replace_keycodes = true, noremap = true, silent = true, desc = "Undo" },
  },
  duplicate_line_below = {
    mode = { "n", "i" },
    lhs = "<D-d>",
    action = a.duplicate_line_below,
    opts = { silent = true, desc = "Duplicate current line below" },
  },
  lsp_show_diagnostics = {
    mode = { "n", "i", "v" },
    lhs = "<D-e>",
    action = a.lsp_show_diagnostics,
    opts = { silent = true, desc = "Show LSP errors in the current line" },
  },
  find_files = {
    mode = { "n", "i", "v" },
    lhs = "<D-f>",
    action = a.find_files,
    opts = { silent = true, desc = "Find files using Telescope" },
  },
  search_in_files = {
    mode = { "n", "i", "v" },
    lhs = "<D-F>",
    action = a.search_in_files,
    opts = { silent = true, desc = "Fuzzy-find in files using Telescope" },
  },
  jump_left = {
    mode = { "n", "i", "v" },
    lhs = "<M-Left>",
    action = a.jump_left,
    opts = { noremap = true, silent = true, desc = "Jump left" },
  },
  jump_right = {
    mode = { "n", "i", "v" },
    lhs = "<M-Right>",
    action = a.jump_right,
    opts = { noremap = true, silent = true, desc = "Jump right" },
  },
  delete_left = {
    mode = { "n", "i", "v" },
    lhs = "<M-BS>",
    action = a.delete_left,
    opts = { noremap = true, silent = true, desc = "Delete left" },
  },
  delete_right = {
    mode = { "n", "i", "v" },
    lhs = "<M-Del>",
    action = a.delete_right,
    opts = { noremap = true, silent = true, desc = "Delete right" },
  },
  toggle_file_tree = {
    mode = { "n", "i" },
    lhs = { "<D-1>", "<D-k1>" },
    action = a.toggle_file_tree,
    opts = { noremap = true, silent = true, desc = "Toggle Neotree" },
  },
  show_in_file_tree = {
    mode = { "n", "i" },
    lhs = "<D-p>",
    action = a.show_in_file_tree,
    opts = { noremap = true, silent = true, desc = "Show file in Neotree" },
  },
  toggle_line_breakpoint = {
    mode = { "n", "i" },
    lhs = "<D-b>",
    action = a.dap_toggle_breakpoint,
    opts = { noremap = true, silent = true, desc = "Toggle line breakpoint on/off" },
  },
  start_continue_debugger = {
    mode = { "n", "i" },
    lhs = "<D-D>",
    action = a.dap_continue,
    opts = { noremap = true, silent = true, desc = "Start / Continue debugging" },
  },
  toggle_debugger_ui = {
    mode = { "n", "i" },
    lhs = { "<D-4>", "<D-k4>" },
    action = a.dapui_toggle,
    opts = { noremap = true, silent = true, desc = "Toggle Debugger UI" },
  },
  show_symbol_documentation = {
    mode = { "n", "i" },
    lhs = "<D-h>",
    action = vim.lsp.buf.hover,
    opts = { noremap = true, silent = true, desc = "Show symbol documentation" },
  },
  goto_symbol_definition_or_usage = {
    mode = "n",
    lhs = { "<leader>gd", "<M-LeftMouse>" },
    action = vim.lsp.buf.definition,
    opts = { noremap = true, silent = true, desc = "Go to symbol definition / usage" },
  },
  goto_symbol_references = {
    mode = "n",
    lhs = { "<leader>gr", "<M-S-LeftMouse>" },
    action = vim.lsp.buf.references,
    opts = { noremap = true, silent = true, desc = "Go to symbol references" },
  },
  show_code_actions = {
    mode = { "n", "i" },
    lhs = "<M-CR>",
    action = vim.lsp.buf.code_action,
    opts = { noremap = true, silent = true, desc = "Show code actions" },
  },
  rename_symbol = {
    mode = "n",
    lhs = "<F18>", -- that's how Shift+F6 gets interpreted
    action = a.rename_symbol,
    opts = { expr = true, noremap = true, silent = true, desc = "Rename symbol under cursor" },
  },
  git_preview_hunk = {
    mode = "n",
    lhs = "<leader>gp",
    action = a.git_preview_hunk,
    opts = { noremap = true, silent = true, desc = "Show the changes of the current hunk" },
  },
  git_reset_hunk = {
    mode = "n",
    lhs = "<leader>gu",
    action = a.git_undo_hunk,
    opts = { noremap = true, silent = true, desc = "Undo / Revert the changes of the current hunk" },
  },
  git_toggle_current_line_blame = {
    mode = "n",
    lhs = "<leader>gt",
    action = a.git_toggle_current_line_blame,
    opts = { noremap = true, silent = true, desc = "Git toggle current line blame" },
  },
  git_blame = {
    mode = "n",
    lhs = "<leader>gb",
    action = a.git_current_file_blame,
    opts = { noremap = true, silent = true, desc = "Git current file blame" },
  },
  show_all_projects = {
    mode = "n",
    lhs = "<leader>pa",
    action = a.show_all_projects,
    opts = { noremap = true, silent = true, desc = "Neovim Project: Show All" },
  },
  show_recent_projects = {
    mode = "n",
    lhs = "<leader>pr",
    action = a.show_recent_projects,
    opts = { noremap = true, silent = true, desc = "Neovim Project: Show Recent" },
  },
  lsp_format_buffer = {
    mode = { "n", "i" },
    lhs = "<M-D-l>",
    action = a.lsp_format_buffer,
    opts = { noremap = true, silent = true, desc = "Format current file" },
  },
  show_lazygit = {
    mode = { "n", "i" },
    lhs = "<D-G>",
    action = a.show_lazygit,
    opts = { noremap = true, silent = true, desc = "Show lazygit" },
  },
  show_keymaps = {
    mode = "n",
    lhs = "<leader>?",
    action = a.show_keymaps,
    opts = { noremap = true, silent = true, desc = "Show keymaps (via which-key)" },
  },
  toggle_comment = {
    mode = { "n", "i", "v" },
    lhs = "<D-/>",
    action = a.toggle_comment,
    opts = { noremap = true, silent = true, desc = "Show keymaps (via which-key)" },
  },
  print_keys_pressed = {
    mode = { "n", "i", "v" },
    lhs = "<F5>",
    action = a.debug_keys_pressed,
    opts = { noremap = true, silent = true, desc = "Listens for key presses and prints them (debug utility)" },
  },
}

function Keymaps.setup(opts)
  local merged = {}
  for key, value in pairs(defaults) do
    merged[key] = vim.tbl_deep_extend("force", value, (opts or {})[key] or {})
  end

  for _, mapping in pairs(merged) do
    if type(mapping.lhs) == "table" then
      for _, lhs in ipairs(mapping.lhs) do
        vim.keymap.set(mapping.mode, lhs, mapping.action, mapping.opts)
      end
    else
      vim.keymap.set(mapping.mode, mapping.lhs, mapping.action, mapping.opts)
    end
  end
end

return Keymaps
