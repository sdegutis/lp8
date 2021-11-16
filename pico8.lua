---@param r number
---@param g number
---@param b number
local function makecolor(r,g,b,a)
  return { r/0xff, g/0xff, b/0xff, a or 1 }
end

local colorTable = {
  makecolor(0x00,0x00,0x00,0),
  makecolor(0x1D,0x2B,0x53),
  makecolor(0x7E,0x25,0x53),
  makecolor(0x00,0x87,0x51),
  makecolor(0xAB,0x52,0x36),
  makecolor(0x5F,0x57,0x4F),
  makecolor(0xC2,0xC3,0xC7),
  makecolor(0xFF,0xF1,0xE8),
  makecolor(0xFF,0x00,0x4D),
  makecolor(0xFF,0xA3,0x00),
  makecolor(0xFF,0xEC,0x27),
  makecolor(0x00,0xE4,0x36),
  makecolor(0x29,0xAD,0xFF),
  makecolor(0x83,0x76,0x9C),
  makecolor(0xFF,0x77,0xA8),
  makecolor(0xFF,0xCC,0xAA),
}

---@class Sprite
---@field image love.Image
---@field flag number
---@field flags boolean[]
local Sprite = {}

local function calcFlags(flag)
  local t = {}
  for i = 0, 7 do
    table.insert(t, i, bit.band(flag, 2^i) > 0)
  end
  return t
end

function Sprite.new(image, flag)
  local spr = {image=image, flag=flag, flags=calcFlags(flag)}
  setmetatable(spr, {__index = Sprite})
  return spr
end

---@param x number
---@param y number
---@param scale number default 1
function Sprite:draw(x, y, scale)
  love.graphics.draw(self.image, x, y, 0, scale, scale)
end

---@param spritesheet string[]
---@param sx number
---@param sy number
---@param w number
---@param h number
---@return love.Image
local function newImageFromSpritesheet(spritesheet, sx, sy, w, h)
  local data = love.image.newImageData(w,h)

  for py = 0, (h-1) do
    local row = sy * 8 + py + 1
    local line = spritesheet[row] or string.rep('0', 128)

    for px = 0, (w-1) do
      local idx = sx * 8 + px + 1
      local hex = line:sub(idx,idx)
      local n = tonumber(hex, 16)
      local color = colorTable[n+1]

      data:setPixel(px, py, color)
    end
  end

  return love.graphics.newImage(data)
end

---@param filename string
local function parseGroups(filename)
  local groups = {}
  local groupname = '__intro__'
  for line in love.filesystem.lines(filename) do
    if line:sub(1,2) == '__' then
      groupname = line
    else
      groups[groupname] = groups[groupname] or {}
      table.insert(groups[groupname], line)
    end
  end
  return groups
end

---Returns a 2d array of sprite indexes.
---Each cell is 2 chars (hex).
---@param map1 string[] 0-32 rows of 256 chars
---@param map2 string[] 0-64 rows of 128 chars
---@return number[][]
local function parseMap(map1, map2)
  -- make them both 0-8192 chars
  map1 = table.concat(map1)
  map2 = table.concat(map2)

  -- pad end of each with 0s
  map1 = map1 .. string.rep('0', 8192-#map1)
  map2 = map2 .. string.rep('0', 8192-#map2)

  -- now we have a whole map we can loop through
  ---@type string
  local map = map1 .. map2

  local output = {}
  local i = 1
  for y = 1, 64 do
    local row = {}
    for x = 1, 128 do
      local hex = map:sub(i,i+1)

      -- reverse gfx-based map pairs
      if y > 32 then hex = hex:reverse() end

      local n = tonumber(hex, 16)
      table.insert(row, n)

      i = i + 2
    end
    table.insert(output, row)
  end

  return output
end

local function parseFlags(gff)
  gff = table.concat(gff)
  gff = gff .. string.rep('0', 512-#gff)

  local flags = {}

  for i = 1, #gff-1, 2 do
    local hex = gff:sub(i, i+1)
    local n = tonumber(hex, 16)
    table.insert(flags, n)
  end

  return flags
end

---returns a sprite mapping per p8 file
---@param filename string relative path
---@param fullMap boolean whether to use the bottom half also
local function parseFile(filename, fullMap)
  local groups = parseGroups(filename)

  local map1 = groups.__map__ or {}
  local map2 = fullMap
    and {unpack(groups.__gfx__, 65)}
    or {}

  ---2d array of map sprite indexes: `map[y][x]`
  local map = parseMap(map1, map2)

  local flags = parseFlags(groups.__gff__ or {})

  return {

    ---Returns a new love.Image for this sprite
    ---@param i number
    ---@param w number pixels wide (default 8)
    ---@param h number pixels tall (default 8)
    ---@return Sprite
    makeSpriteAt = function(i, w, h)
      local sx = i % 16
      local sy = math.floor(i / 16)
      local img = newImageFromSpritesheet(groups.__gfx__, sx, sy, w or 8, h or 8)
      return Sprite.new(img, flags[i+1])
    end,

    map = map,

  }
end

return {
  parseFile=parseFile,
}
