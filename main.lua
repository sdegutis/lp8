local lib = require("lib")
local sprs

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.window.setMode(800, 600)
  sprs = lib.parseFile("test1.p8")
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
