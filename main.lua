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
  junkData = { 
    images = {
      love.graphics.newImage("images/bolt.png") 
      
    },
    dx = { 75, 100 },
    dy = { 90, 120 },
    dr = { 10, 30 },
    ay = 600
    
  }
  direction = function()
    if math.random(0,1) == 0 then
      return -1
    else
      return 1
    end
  end
  makeJunk = function(x,y,amount)
    for i = 1, amount do
      local junk = {
        x = x + math.random(-20,20),
        y = y + math.random(-20,20),
        dx = direction() * math.random(junkData.dx[1], junkData.dx[2]), 
        dy = -1 * math.random(junkData.dy[1], junkData.dy[2]),
        r = math.random(1,100), 
        dr = direction() * math.random(junkData.dr[1], junkData.dr[2]),
        image = junkData.images[1]
      }
      table.insert(junkItems, junk)
    end
  end
  
  junkItems = {}
  
  looky = require "looky"
  ease = require "easy"
  
  looky:registerLayout("computer", require("layouts/computer")(looky))
  looky:registerLayout("face", require("layouts/face")(looky))
  
  root = looky:build("stackroot")
  
  root:addListener({ junk = function(self, signal, payload, coords)
    if signal == "smashed" then      
      makeJunk(coords[1].x,coords[1].y,10)
    end
  end}, "junk")
  
  serverRoomView = looky:build("grid", { rows = 4, columns = 4, width = "fill", height = "fill", padding = looky.padding(25), background = { 45, 35, 35, 255 } })
  for i = 1, 4 do
    for j = 1, 4 do
      serverRoomView:setChild( looky:build("computer"), i, j)
    end
  end
  
  renderHammer = function(self)
    love.graphics.setColor(255,255,255,255)    
    love.graphics.draw(hammer.image, hammer.x, hammer.y, hammer.r, 2, 2, hammer.image:getWidth() / 2, hammer.image:getHeight())
    
    for _, j in ipairs(junkItems) do
      love.graphics.draw(j.image, j.x, j.y, j.r, 1, 1, j.image:getWidth()/2, j.image:getHeight()/2)
    end
    
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
    hammer.r = -ease("quintin", hammer.progress) * (math.pi / 2)
    if hammer.progress > 1 then
      hammer.smashing = "up"
      hammer.progress = 0  
      root:receiveOutsideSignal("hit", { type = "hammer" }, { { x = hammer.x - 85, y = hammer.y + 20} })
    end
  end
  
  if hammer.smashing == "up" then
    hammer.progress = hammer.progress + (dt*3) 
    hammer.r = (ease("circinout", hammer.progress) - 1) * (math.pi/2)
    if hammer.progress > 1 then
      hammer.smashing = nil
      hammer.progress = 0
      hammer.r = 0
    end
  end
  
  for _, j in ipairs(junkItems) do
    j.x = j.x + ( j.dx * dt )
    j.y = j.y + ( j.dy * dt )
    j.dy = j.dy + ( junkData.ay * dt )
    j.r = j.r + ( j.dr * dt )
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