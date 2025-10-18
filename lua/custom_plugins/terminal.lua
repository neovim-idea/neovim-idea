local M = {}
--[[
-- NOTE disabled because mini.terminal & edgy.nvim should behave more nicely 

local terminal_buf = nil

function M.toggle_terminal()
	if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
		vim.api.nvim_set_current_buf(terminal_buf)
	else
		vim.cmd("botright 10split | terminal")
		terminal_buf = vim.api.nvim_get_current_buf()
	end
end

M.setup = function()
	vim.api.nvim_create_user_command("ToggleTerminal", M.toggle_terminal, { desc = "Toggle terminal visibility" })
end
--]]

return M
