if pcall(require, "lldebugger") then require("lldebugger").start() end
if pcall(require, "mobdebug") then require("mobdebug").start() end
love.graphics.setDefaultFilter("nearest", "nearest")
love.window.setMode(800, 600)

local pico8 = require("pico8")
local basics = pico8.parseFile("test2.p8")

local map = basics.makeMap(true)

function love.load()

end

local cachedSprites = {}
---Creates or returns already created sprite
---@param i number sprite index
---@param w number pixels wide (default 8)
---@param h number pixels tall (default 8)
local function cachedSpriteAt(i, w, h)
  if not cachedSprites[i] then
    cachedSprites[i] = basics.makeSpriteAt(i, w, h)
  end
  return cachedSprites[i]
end

function love.draw()
  love.graphics.clear()

  local mx, my = love.mouse.getPosition()
  local mapx = mx - (128 * 8 / 2)
  local mapy = my - (64 * 8 / 2)

  love.graphics.setColor(1,1,1)
  love.graphics.rectangle('line', mapx-1, mapy-1, 128*8+1, 64*8+1)

  for y = 1, 64 do
    for x = 1, 128 do
      local spri = map[y][x]
      local spr = cachedSpriteAt(spri)
      love.graphics.draw(spr, mapx + (x-1)*8, mapy + (y-1)*8)
    end
  end

  love.graphics.draw(cachedSpriteAt(0),  10*3, 10, 0, 2, 2)
  love.graphics.draw(cachedSpriteAt(1),  20*3, 10, 0, 2, 2)
  love.graphics.draw(cachedSpriteAt(2),  30*3, 10, 0, 2, 2)
  love.graphics.draw(cachedSpriteAt(3),  40*3, 10, 0, 2, 2)
  love.graphics.draw(cachedSpriteAt(17), 50*3, 10, 0, 2, 2)
  love.graphics.draw(cachedSpriteAt(18), 60*3, 10, 0, 2, 2)
  love.graphics.draw(cachedSpriteAt(19), 70*3, 10, 0, 2, 2)
  love.graphics.draw(cachedSpriteAt(37), 80*3, 10, 0, 2, 2)
  love.graphics.draw(cachedSpriteAt(4, 16, 16), 90*3, 10, 0, 2, 2)
end
