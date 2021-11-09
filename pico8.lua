
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
---@return love.Image
local function getSpriteAt(spritesheet, sx, sy)
  local data = love.image.newImageData(8,8)

  for py = 0, 7 do
    local row = sy * 8 + py + 1
    local line = spritesheet[row] or string.rep('0', 128)

    for px = 0, 7 do
      local idx = sx * 8 + px + 1
      local hex = line:sub(idx,idx)
      local n = tonumber(hex, 16)
      local color = colorTable[n+1]

      data:setPixel(px, py, color)
    end
  end

  return love.graphics.newImage(data)
end

local function linesBetween(lineIter, before, after)
  local lines = {}
  for line in lineIter do
    if line == before then break end
  end
  for line in lineIter do
    if line == after then break end
    table.insert(lines, line)
  end
  return lines
end

---returns a sprite mapping per p8 file
---@param filename string
---@return love.Image[]
local function parseFile(filename)
  local lineIter = love.filesystem.lines(filename)
  local spritesheet = linesBetween(lineIter, "__gfx__", "")
  local sprites = {}
  local i = 0
  for sy = 0, 15 do
    for sx = 0, 15 do
      local sprite = getSpriteAt(spritesheet, sx, sy)
      table.insert(sprites, i, sprite)
      i = i + 1
    end
  end
  return {
    sprites=sprites,
  }
end

return {
  parseFile=parseFile,
}
