if arg[#arg] == "-debug" then debug = true else debug = false end
if debug then require("mobdebug").start() end

love.load = function()
  
  junk = require "junk"
  hammer = require "hammer"
  hammer.load()
  
  love.mouse.setVisible(false)

  images = {
    monitor = love.graphics.newImage("images/monitor.png")
  }
  faces = {
    smile = love.graphics.newImage("images/faces/smile.png"),
    sad = love.graphics.newImage("images/faces/sad.png"),
    dead = love.graphics.newImage("images/faces/dead.png"),
    
  }
  
  looky = require "looky"
  ease = require "easy"  
  root = require "baselayout"
  
  junk.load()
  
  root:layoutingPass()
  
end

love.update = function(dt)
 
  junk.update(dt)
  hammer.update(dt)
   
end

love.mousepressed = function(x,y,button)
  hammer.mousepressed(x,y,button)
end

love.draw = function()
  root:render()
end