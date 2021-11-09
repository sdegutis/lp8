if pcall(require, "lldebugger") then require("lldebugger").start() end
if pcall(require, "mobdebug") then require("mobdebug").start() end
love.graphics.setDefaultFilter("nearest", "nearest")
love.window.setMode(800, 600)

local pico8 = require("pico8")
local basics = pico8.parseFile("test2.p8")

function love.load()
  
end

function love.draw()
  love.graphics.clear()
  love.graphics.draw(basics.makeSpriteAt(0),  10*3, 10, 0, 2, 2)
  love.graphics.draw(basics.makeSpriteAt(1),  20*3, 10, 0, 2, 2)
  love.graphics.draw(basics.makeSpriteAt(2),  30*3, 10, 0, 2, 2)
  love.graphics.draw(basics.makeSpriteAt(3),  40*3, 10, 0, 2, 2)
  love.graphics.draw(basics.makeSpriteAt(17), 50*3, 10, 0, 2, 2)
  love.graphics.draw(basics.makeSpriteAt(18), 60*3, 10, 0, 2, 2)
  love.graphics.draw(basics.makeSpriteAt(19), 70*3, 10, 0, 2, 2)
  love.graphics.draw(basics.makeSpriteAt(37), 80*3, 10, 0, 2, 2)
  love.graphics.draw(basics.makeSpriteAt(4, 16, 16), 90*3, 10, 0, 2, 2)
end
