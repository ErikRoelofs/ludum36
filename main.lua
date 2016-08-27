love.load = function()
  love.mouse.setVisible(false)
  
  hammer = {
    image = love.graphics.newImage("images/hammer.png"),
    x = 0,
    y = 0
  }
  
  looky = require "looky"
  
  root = looky:build("stackroot")
  
  hammerPane = looky:build("dragbox", {width = "fill", height="fill"})
  hammerView = looky:build("image", {width="wrap", height="wrap", file=hammer.image})
  
  root:addChild(hammerPane)
  hammerPane:addChild(hammerView)
  
  
  root:layoutingPass()
end

love.update = function(dt)
  hammer.x, hammer.y = love.mouse.getPosition()
  hammerPane.offset = {hammer.x - hammer.image:getWidth()  / 2, hammer.y - hammer.image:getHeight()}
  root:update(dt)
end

love.draw = function()
  root:render()
end