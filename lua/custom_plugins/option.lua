-- Lua-ish implementation of Scala's Option[A] class
local M = {}

local Some_mt = {
  isDefined = true,
  isEmpty = false,
}

local None_mt = {
  isDefined = false,
  isEmpty = true,
}

-- helper constructors
local function Some(value)
  return setmetatable({ _value = value }, Some_mt)
end

local function None()
  return setmetatable({}, None_mt)
end

local _NONE = None()

-- the Option[A](a) constructor
function M.Option(value)
  if value == nil then
    return _NONE
  end
  return Some(value)
end

-- the Option.when[A](condition)(a: => A) utility
function M.when(condition, value_or_fn)
  if not condition then
    return _NONE
  end
  local v = value_or_fn
  if type(value_or_fn) == "function" then
    v = value_or_fn()
  end
  return M.Option(v)
end

-- TODO: implement Option.unless[A](condition)(a: => A)

-- private utility to make sure we're working with an object that is an instance of Optiob
local function is_option(obj)
  local mt = getmetatable(obj)
  return mt == Some_mt or mt == None_mt
end

-- Some methods
function Some_mt:map(fn)
  assert(type(fn) == "function", "map expects a function")
  local res = fn(self._value)
  return M.Option(res)
end

function Some_mt:flatMap(fn)
  assert(type(fn) == "function", "flatMap expects a function")
  local res = fn(self._value)
  if not is_option(res) then
    error("flatMap function must return an Option")
  end
  return res
end

function Some_mt:get()
  return self._value
end

function Some_mt:getOrElse(default)
  return self._value
end

function Some_mt:orElse(other)
  return self
end

function Some_mt:foreach(fn)
  assert(type(fn) == "function", "foreach expects a function")
  fn(self._value)
end

function Some_mt:__tostring()
  return ("Some(%s)"):format(tostring(self._value))
end

-- None methods
function None_mt:map(fn)
  return _NONE
end

function None_mt:flatMap(fn)
  return _NONE
end

function None_mt:get()
  error("No such element: None.get")
end

function None_mt:getOrElse(default)
  return default
end

function None_mt:orElse(other)
  return other
end

function None_mt:foreach(fn) end

function None_mt:__tostring()
  return "None"
end

-- expose helpers if user wants to check exact types
M.Some = Some
M.None = _NONE

-- alias Option.when as top-level name as well
M.Option.when = M.when

return M
