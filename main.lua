if pcall(require, "lldebugger") then require("lldebugger").start() end
if pcall(require, "mobdebug") then require("mobdebug").start() end

local winw, winh = love.window.getMode()
if winw ~= 800 or winh ~= 600 then
  love.window.setMode(800, 600)
end

love.graphics.setDefaultFilter("nearest", "nearest")

local pico8 = require("pico8")
local basics = pico8.parseFile("test2.p8", true)

function love.load()

end

local cachedSprites = {}
local function getCachedSprite(i, w, h)
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
      local spri = basics.map[y][x]
      local spr = getCachedSprite(spri)
      spr:draw(mapx + (x-1)*8, mapy + (y-1)*8)
    end
  end

  getCachedSprite(0):draw(  10*3, 10, 3)
  getCachedSprite(1):draw(  20*3, 10, 3)
  getCachedSprite(2):draw(  30*3, 10, 3)
  getCachedSprite(3):draw(  40*3, 10, 3)
  getCachedSprite(17):draw( 50*3, 10, 3)
  getCachedSprite(18):draw( 60*3, 10, 3)
  getCachedSprite(19):draw( 70*3, 10, 3)
  getCachedSprite(37):draw( 80*3, 10, 3)
  getCachedSprite(4, 16, 16):draw( 90*3, 10, 3)
end
