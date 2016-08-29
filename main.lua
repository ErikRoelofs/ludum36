if arg[#arg] == "-debug" then debug = true else debug = false end
if debug then require("mobdebug").start() end

love.load = function()
  
  require "computer/computerModel"
  require "computer/behaviors"
  
  junk = require "junk"
  hammer = require "hammer"
  hammer.load()
  smoke = require "smoke"
  
  love.mouse.setVisible(true)

  images = {
    monitor = love.graphics.newImage("images/monitor.png"),
    smoke = love.graphics.newImage("images/junk/smoke.png")
  }
  faces = {
    smile = love.graphics.newImage("images/faces/smile.png"),
    sad = love.graphics.newImage("images/faces/sad.png"),
    dead = love.graphics.newImage("images/faces/dead.png"),
    
  }
  
  rows = 4
  columns = 4
  computers = {}
  
  for i = 1, rows do
    for j = 1, columns do
      local faction = "bad"
      if math.random(0,1) == 1 then
        faction = "good"
      end
      table.insert(computers, newComputer("(" .. i .. "," .. j .. ")", faction))
    end
  end

  getComputer = function(i,j)
    return computers[i + ((j-1) * columns)]
  end
  
  renderOvermap = function(self)
    love.graphics.setColor(255,255,255,255)    
    love.graphics.draw(hammerModel.image, hammerModel.x, hammerModel.y, hammerModel.r, 2, 2, hammerModel.image:getWidth() / 2, hammerModel.image:getHeight())
    
    for _, j in ipairs(junkItems) do
      love.graphics.draw(j.image, j.x, j.y, j.r, 1.5, 1.5, j.image:getWidth()/2, j.image:getHeight()/2)
    end
    
    for _, smoke in ipairs(smokeItems) do
      love.graphics.draw(smoke.ps, smoke.x, smoke.y)
    end
    
  end

  
  looky = require "looky"
  ease = require "easy"  
  root = require "baselayout"
  
  junk.load()
  smoke.load()
  
  root:layoutingPass()
  
 
end

love.update = function(dt)
 
  junk.update(dt)
  hammer.update(dt)
  smoke.update(dt)
  
end

love.mousepressed = function(x,y,button)
  hammer.mousepressed(x,y,button)
end

love.draw = function()
  root:render()
  
end