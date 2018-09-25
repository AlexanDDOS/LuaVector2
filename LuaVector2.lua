--[[
LuaVector2

Copyright (c) 2018 Alexander Osipov

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

local Vector2 = {}

local function sign(t)
  if t == 0 then
    return 0
  elseif t < 0 then
    return -1
  end
  return 1
end

local function unpack(t) -- Global unpack() still be available as _G.unpack()
  local x, y
  x = t.x or t[1]
  y = t.y or t[2]
  return x, y
end
Vector2.unpack = unpack

local function factor(f) -- Convert factor f to an {x, y} sequence
  if type(f) == 'number' then
    return f, f
  end
  return unpack(f)
end

local function new(x, y)
  local t = {}
  t.x = x or 0
  t.y = y or 0
  return setmetatable(t, Vector2)
end
Vector2.new = new


function Vector2.__index(t, k)
  if k == 'x' then
    return rawget(t, 1)
  elseif k == 'y' then
    return rawget(t, 2)
  end
  return rawget(t, k) or Vector2[k]
end

function Vector2.__newindex(t, k, v)
  if k == 'x' then
    return rawset(t, 1, v)
  elseif k == 'y' then
    return rawset(t, 2, v)
  end
  return rawset(t, k, v)
end

function Vector2.__tostring(t)
  return string.format("(%s, %s)", t.x, t.y)
end

function Vector2.__pairs(t)
  return pairs({x = t.x, y = t.y})
end

function Vector2.__ipairs(t)
  return ipairs({t.x, t.y})
end

function Vector2.__concat(a, b)
  local t = {}
  local al = #a
  
  for i = 1, al do
    t[i] = a[i]
  end
  
  for i = 1, #b do
    t[al + i] = b[i]
  end
  
  return t
end

--Vector math
function Vector2.__add(t1, t2)
  local x1, y1 = unpack(t1)
  local x2, y2 = unpack(t2)
  return new(x1 + x2, y1 + y2)
end

function Vector2.__sub(t1, t2)
  local x1, y1 = unpack(t1)
  local x2, y2 = unpack(t2)
  return new(x1 - x2, y1 - y2)
end

function Vector2.__mul(t1, t2)
  local x1, y1 = factor(t1)
  local x2, y2 = factor(t2)
  return new(x1 * x2, y1 * y2)
end

function Vector2.__div(t1, t2)
  local x1, y1 = factor(t1)
  local x2, y2 = factor(t2)
  return new(x1 / x2, y1 / y2)
end

function Vector2.__mod(t1, t2)
  local x1, y1 = factor(t1)
  local x2, y2 = factor(t2)
  return new(x1 % y1, x2 % y2)
end

function Vector2.__pow(t1, t2)
  local x1, y1 = factor(t1)
  local x2, y2 = factor(t2)
  return new(x1 ^ y1, x2 ^ y2)
end

function Vector2.__eq(t1, t2)
  local x1, y1 = unpack(t1)
  local x2, y2 = unpack(t2)
  return x1 == x2 and y1 == y2
end

function Vector2.__lt(t1, t2)
  local x1, y1 = unpack(t1)
  local x2, y2 = unpack(t2)
  return x1 < x2 or y1 < y2
end

function Vector2.__le(t1, t2)
  local x1, y1 = unpack(t1)
  local x2, y2 = unpack(t2)
  return x1 <= x2 and y1 <= y2
end

function Vector2.__unm(t)
  return new(-t.x, -t.y)
end
--End of the math

--Constant vectors
Vector2.ZERO = new(0, 0)
Vector2.ONE = new(1, 1)
Vector2.INF = new(math.huge, math.huge)

Vector2.RIGHT = new(1, 0)
Vector2.DOWN = new(0, 1)

Vector2.LEFT = -Vector2.RIGHT
Vector2.UP = -Vector2.DOWN
Vector2.NEG_ONE = -Vector2.ONE
Vector2.NEG_INF = -Vector2.INF

--Copying
function Vector2.copy(t)
  return new(t.x, t.y)
end

--Overriding the values
function Vector2.override(t, x, y)
  t.x, t.y = x, y
end

--Distance functions
function Vector2.sqDist(t, to)
  local x2, y2 = 0, 0
  if to then
    x2, y2 = unpack(to)
  end
  local dx, dy = x2 - t.x, y2 - t.y
  return dx*dx + dy*dy
end

function Vector2.dist(t, to)
  return math.sqrt(t:sqDist(to))
end

--Rounding functions
function Vector2.floor(t)
  return new(math.floor(t.x), math.floor(t.y))
end

function Vector2.ceil(t) --Say hello to Godot developers
  return new(math.ceil(t.x), math.ceil(t.y))
end

--Absolute function
function Vector2.abs(t)
  return new(math.abs(t.x), math.abs(t.y))
end

--Normalization
function Vector2.normalize(t, unit)
  unit = unit or 1
  local d = t:dist() / unit
  return new(t.x / d, t.y / d)
end

--Angle functions
function Vector2.fromAngle(a, d)
  d = d or 1
  return new(math.cos(a) * d, math.sin(a) * d)
end

function Vector2.toAngle(t, deg)
  local n = t:normalize()
  local a
  
  if n.y == 0 then --asin(0) has ambiguous result IRL but always returns 0 in Lua
    a = n.x * math.pi --acos(n.x) is always 1 or -1 while asin(t.y) = 0 
  else
    a = math.asin(n.y)
  end
  
  if deg then
    return math.deg(a)
  end 
  return a
end

--Other maths
function Vector2.dotProduct(a, b)
  return a[1] * b[1] + a[2] * b[2]
end

function Vector2.compareValues(t)
  if t.x < t.y then
    return -1
  elseif t.x > t.y then
    return 1
  end
  return 0
end

function Vector2.sign(t)
  return new(sign(t.x), sign(t.y))
end

return Vector2