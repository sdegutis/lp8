if pcall(require, "lldebugger") then require("lldebugger").start() end
if pcall(require, "mobdebug") then require("mobdebug").start() end
love.graphics.setDefaultFilter("nearest", "nearest")
love.window.setMode(800, 600)

local pico8 = require("pico8")
local basics = pico8.parseFile("test2.p8")

local map = basics.makeMap(true)

function love.load()

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
      local spr = basics.spriteAt(spri)
      love.graphics.draw(spr, mapx + (x-1)*8, mapy + (y-1)*8)
    end
  end

  love.graphics.draw(basics.spriteAt(0),  10*3, 10, 0, 2, 2)
  love.graphics.draw(basics.spriteAt(1),  20*3, 10, 0, 2, 2)
  love.graphics.draw(basics.spriteAt(2),  30*3, 10, 0, 2, 2)
  love.graphics.draw(basics.spriteAt(3),  40*3, 10, 0, 2, 2)
  love.graphics.draw(basics.spriteAt(17), 50*3, 10, 0, 2, 2)
  love.graphics.draw(basics.spriteAt(18), 60*3, 10, 0, 2, 2)
  love.graphics.draw(basics.spriteAt(19), 70*3, 10, 0, 2, 2)
  love.graphics.draw(basics.spriteAt(37), 80*3, 10, 0, 2, 2)
  love.graphics.draw(basics.spriteAt(4, 16, 16), 90*3, 10, 0, 2, 2)
end
