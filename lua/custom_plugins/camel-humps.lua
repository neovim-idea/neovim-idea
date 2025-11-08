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

string.foldLeft = function(the_string, z, op)
  for i = 1, #the_string, 1 do
    z = op(the_string:sub(i, i), z)
  end
  return z
end

local CharacterType = {
  LOWERCASE = 1,
  UPPERCASE = 2,
  WHITESPACE = 3,
  SPECIAL = 4,
}

local function char_type(ch)
  if special_chars:find(ch, 1, true) then
    return CharacterType.SPECIAL
  elseif ch:match("^%s$") ~= nil then
    return CharacterType.WHITESPACE
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
  -- if there are no alphanumeric words availalbe -> move to the beginning
  if word == nil then
    return { cursor_col = 0, cursor_line = 0 }
  end

  ---@diagnostic disable-next-line: need-check-nil
  local result = word:foldRight({ start_type = nil, pivot_type = nil, counter = 0 }, function(ch, acc)
    if acc.start_type ~= nil and acc.pivot_type ~= nil then
      return acc
    end

    local new_type = char_type(ch)

    -- shouldn't happen at all since here (left_camel_hump) we get process a word, but still... be defensive and skip
    if new_type == CharacterType.WHITESPACE then
      return acc
    end

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

  return { cursor_col = rightmost_word_position + (#word - result.counter) - 1, cursor_line = 0 }
end

local function right_camel_hump(line)
  -- empty line? then jump down one line
  if line == nil or line == "" or #line <= 1 then
    return { cursor_col = nil, cursor_line = 1 }
  end

  local result = line:foldLeft(
    { start_type = nil, pivot_type = nil, counter = 0, extra_search = false },
    function(ch, acc)
      local new_type = char_type(ch)
      -- initialise the starting type of the character we are
      if acc.start_type == nil then
        acc.start_type = new_type
        acc.counter = acc.counter + 1
        return acc
      end

      -- if we don't have encountered a pivot character yet ...
      if acc.pivot_type == nil then
        -- and new_type is different than start_type => we found the pivot
        if new_type ~= acc.start_type and new_type == CharacterType.WHITESPACE then
          -- but, in case the pivot is a whitespace .. continue searching for a different pivot
          acc.start_type = new_type
        elseif new_type ~= acc.start_type then
          acc.pivot_type = new_type
        end
        -- in any case, don't forget to increase the counter and return
        acc.counter = acc.counter + 1
        return acc
      end

      -- -- keep iterating if we hit lowercase -> uppercase transition or viceversa
      -- if
      --   (
      --     (
      --       acc.start_type == CharacterType.LOWERCASE
      --       and acc.pivot_type == CharacterType.UPPERCASE
      --       and acc.pivot_type == new_type
      --     )
      --     or (
      --       acc.start_type == CharacterType.UPPERCASE
      --       and acc.pivot_type == CharacterType.LOWERCASE
      --       and acc.pivot_type == new_type
      --     )
      --   ) and acc.extra_search == false
      -- then
      --   acc.counter = acc.counter + 1
      -- end

      return acc
    end
  )

  local final_position = { cursor_col = result.counter, cursor_line = 0 }
  print(
    "LINE: '"
      .. tostring(line)
      .. "', JUMP_TO: '"
      .. tostring(result.counter)
      .. "', JUMP_TO: '"
      .. tostring(line:sub(0, final_position.cursor_col))
      .. "'"
  )
  return final_position
end

-- TODO: give the user the ability to override regexps and/or the entire functions ?
local function setup(opts) end

--[[ API DEFINITION ]]

M.left_camel_hump = left_camel_hump
M.right_camel_hump = right_camel_hump

return M
