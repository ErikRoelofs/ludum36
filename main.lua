if arg[#arg] == "-debug" then debug = true else debug = false end
if debug then require("mobdebug").start() end


love.load = function()
  love.mouse.setVisible(false)
  
  hammer = {
    image = love.graphics.newImage("images/hammer.png"),
    x = 0,
    y = 0
  }
  
  looky = require "looky"
  
  looky:registerLayout("computer", require("layouts/computer")(looky))
  looky:registerLayout("face", require("layouts/face")(looky))
  
  root = looky:build("stackroot")
  
  serverRoomView = looky:build("grid", { rows = 6, columns = 6, width = "fill", height = "fill", padding = looky.padding(25), background = { 45, 35, 35, 255 } })
  for i = 1, 6 do
    for j = 1, 6 do
      serverRoomView:setChild( looky:build("computer"), i, j)
    end
  end
  
  hammerPane = looky:build("dragbox", {width = "fill", height="fill"})
  hammerView = looky:build("image", {width="wrap", height="wrap", file=hammer.image})
  hammerPane:addChild(hammerView)
  
  root:addChild(serverRoomView)
  root:addChild(hammerPane)
  
  
  
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