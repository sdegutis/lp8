if pcall(require, "lldebugger") then require("lldebugger").start() end
if pcall(require, "mobdebug") then require("mobdebug").start() end

local pico8 = require("pico8")
local sprs

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.window.setMode(800, 600)
  local p8data = pico8.parseFile("test2.p8")
  sprs = p8data.sprites
end

function love.draw()
  love.graphics.clear()
  love.graphics.draw(sprs[0],  10*3, 10, 0, 2, 2)
  love.graphics.draw(sprs[1],  20*3, 10, 0, 2, 2)
  love.graphics.draw(sprs[2],  30*3, 10, 0, 2, 2)
  love.graphics.draw(sprs[3],  40*3, 10, 0, 2, 2)
  love.graphics.draw(sprs[17], 50*3, 10, 0, 2, 2)
  love.graphics.draw(sprs[18], 60*3, 10, 0, 2, 2)
  love.graphics.draw(sprs[19], 70*3, 10, 0, 2, 2)
  love.graphics.draw(sprs[37], 80*3, 10, 0, 2, 2)
end
