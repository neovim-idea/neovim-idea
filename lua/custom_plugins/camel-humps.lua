local M = {}
--[[ TODO: write proper tests rather than having these

 final case class MyWonderfulConfigClass  ( foo: String, someBar: Option[SomeBaz]) {
    for {
      a <----- myWonderfulConfigClass.doSomethingCool     (    withIt,      but { beeeee VeryCareful } )
      _ = otherwiseBadThings.couldBe[ HappeningWihtTypes ] ( butIhopeNotTough )
      _ <- I_DUNNO_WHAT_IM_DOING_IN_HERE
    } yield new Something { override def foo: unit = ??? } test??
 }

 ]]
local special_chars = "()[]{},.=~!?|&+-*:/<>@#_"

string.foldRight = function(the_string, z, op)
  for i = #the_string, 1, -1 do
    z = op(the_string:sub(i, i), z)
  end
  return z
end

local CharacterType = {
  LOWERCASE = 1,
  UPPERCASE = 2,
  SPECIAL = 3,
}

local function char_type(ch)
  if special_chars:find(ch, 1, true) then
    return CharacterType.SPECIAL
  elseif ch:match("%u") then
    return CharacterType.UPPERCASE
  else
    return CharacterType.LOWERCASE
  end
end

local function left_camel_hump(line)
  -- empty line? then jump up one line
  if line == nil or line == "" then
    return { cursor_col = nil, cursor_line = -1 }
  end

  local rightmost_word_position, word = line:match("()(%S-)[" .. special_chars:gsub("(%p)", "%%%1") .. "]*%s*$")
  -- if there are no alphanumeric words availalbe ...
  if word == nil then
    -- but, if the line has still whitespaces -> move to the beginning
    return { cursor_col = 0, cursor_line = 0 }
  end

  local log = ""

  local function add_log(action)
    if log == "" then
      log = action
    else
      log = log .. " -> " .. action
    end
  end

  add_log("word: '" .. word .. "'")

  ---@diagnostic disable-next-line: need-check-nil
  local result = word:foldRight({ start_type = nil, pivot_type = nil, counter = 0 }, function(ch, acc)
    if acc.start_type ~= nil and acc.pivot_type ~= nil then
      return acc
    end

    local new_type = char_type(ch)
    add_log(ch)
    if acc.start_type == nil then
      acc.counter = 1
      acc.start_type = new_type
      return acc
    end

    if new_type == acc.start_type and acc.pivot_type == nil then
      acc.counter = acc.counter + 1
      return acc
    end

    if new_type ~= acc.start_type then
      acc.pivot_type = new_type
      -- if we pivot from a alpanumerical character to a special one, stop on the alphanumerical one.
      -- i.e. in ".foobar" we stop at "f"
      if
        not (
          (acc.start_type == CharacterType.LOWERCASE or acc.start_type == CharacterType.UPPERCASE)
          and new_type == CharacterType.SPECIAL
        )
      then
        acc.counter = acc.counter + 1
      end
      return acc
    end
  end)

  -- debug to check the chars that were inspected
  -- print(log)

  local final_position = { cursor_col = rightmost_word_position + (#word - result.counter) - 1, cursor_line = 0 }
  return final_position
end

-- TODO: give the user the ability to override regexps and/or the entire functions ?
local function setup(opts) end

--[[ API DEFINITION ]]

M.left_camel_hump = left_camel_hump

return M
