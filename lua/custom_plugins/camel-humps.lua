local M = {}

local special_chars = "()[]{},.=~!?|&+-*:/<>@#_"

-- Function to check if a character is a special character
local function is_special_char(chars)
	return string.find(special_chars, chars) ~= nil
end

-- Lua-ish implementation of foldRight[B](z: B)(op: (A, B) => B): B
string.foldRight = function(the_string, z, op)
	local acc = z
	for i = #the_string, 1, -1 do
		local ch = the_string:sub(i, i)
		acc = op(ch, acc)
	end
	return acc
end

local function left_camel_hump(opts)
	-- the content on the left side of the cursor (included)
	local line_content = opts.left_side_line_content
	-- the position of the line in the whole document
	local line_pos = opts.line_pos
	-- total lines of the document
	local total_lines = opts.total_lines

	local closest_lowercase = line_content.foldRight({}, function(ch, acc)
		-- implement me
	end)
	local closest_uppercase = nil
	local closest_symbol = nil
end

return M
