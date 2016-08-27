love.load = function()
  looky = require "looky"
  
  root = looky:build("root")
  
  root:layoutingPass()
end

love.update = function(dt)
  
end

love.draw = function()
  root:render()
end