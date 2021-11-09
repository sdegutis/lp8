local lib = require("lib")

local sprs = lib.parseFile("test1.p8")

function love.draw()
  love.graphics.clear()
  love.graphics.draw(sprs[0],  10, 10)
  love.graphics.draw(sprs[1],  20, 10)
  love.graphics.draw(sprs[2],  30, 10)
  love.graphics.draw(sprs[3],  40, 10)
  love.graphics.draw(sprs[17], 50, 10)
  love.graphics.draw(sprs[18], 60, 10)
  love.graphics.draw(sprs[19], 70, 10)
  love.graphics.draw(sprs[37], 80, 10)
end
