
---@param r number
---@param g number
---@param b number
local function makecolor(r,g,b)
  return { r/0xff, g/0xff, b/0xff }
end

local colorTable = {
  makecolor(0x00,0x00,0x00),
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

---@param spritesheet string[]
---@param sx number
---@param sy number
---@param w number
---@param h number
---@return love.Image
local function getSpriteAt(spritesheet, sx, sy, w, h)
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

---returns a sprite mapping per p8 file
---@param filename string
local function parseFile(filename)
  local groups = parseGroups(filename)
  local spritesheet = groups.__gfx__
  return {
    ---@param i number
    ---@return love.Image
    makeSpriteAt = function(i, w, h)
      local sx = i % 16
      local sy = math.floor(i / 16)
      return getSpriteAt(spritesheet, sx, sy, w or 8, h or 8)
    end
  }
end

return {
  parseFile=parseFile,
}
