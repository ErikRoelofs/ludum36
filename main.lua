if arg[#arg] == "-debug" then debug = true else debug = false end
if debug then require("mobdebug").start() end


love.load = function()
  love.mouse.setVisible(false)
  
  hammer = {
    image = love.graphics.newImage("images/hammer.png"),
    x = 0,
    y = 0,
    smashing = false,
    progress = 0,
  }
  
  looky = require "looky"
  ease = require "easy"
  
  looky:registerLayout("computer", require("layouts/computer")(looky))
  looky:registerLayout("face", require("layouts/face")(looky))
  
  root = looky:build("stackroot")
  
  serverRoomView = looky:build("grid", { rows = 4, columns = 4, width = "fill", height = "fill", padding = looky.padding(25), background = { 45, 35, 35, 255 } })
  for i = 1, 4 do
    for j = 1, 4 do
      serverRoomView:setChild( looky:build("computer"), i, j)
    end
  end
  
  renderHammer = function(self)
    love.graphics.setColor(255,255,255,255)    
    love.graphics.draw(hammer.image, hammer.x, hammer.y, hammer.r, 2, 2, hammer.image:getWidth() / 2, hammer.image:getHeight())
  end
  hammerPane = looky:build("freeform", {width = "fill", height="fill", render = renderHammer})
  
  root:addChild(serverRoomView)
  root:addChild(hammerPane)
  
  
  
  root:layoutingPass()
end

love.update = function(dt)
  hammer.x, hammer.y = love.mouse.getPosition()
  hammerPane.offset = {hammer.x - hammer.image:getWidth()  / 2, hammer.y - hammer.image:getHeight()}
  root:update(dt)
  
  if hammer.smashing == "down" then
    hammer.progress = hammer.progress + (dt*5)
    hammer.r = -ease("quintin", hammer.progress)
    if hammer.progress > 1 then
      hammer.smashing = "up"
      hammer.progress = 0  
      root:receiveOutsideSignal("hit", { type = "hammer" }, { { x = hammer.x, y = hammer.y } })
    end
  end
  
  if hammer.smashing == "up" then
    hammer.progress = hammer.progress + (dt*3)
    hammer.r = ease("circinout", hammer.progress) - 1
    if hammer.progress > 1 then
      hammer.smashing = nil
      hammer.progress = 0
    end
  end
  
end

love.mousepressed = function()
  if not hammer.smashing then
    hammer.smashing = "down"  
  end
end

love.draw = function()
  root:render()
end