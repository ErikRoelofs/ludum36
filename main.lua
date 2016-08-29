if arg[#arg] == "-debug" then debug = true else debug = false end
if debug then require("mobdebug").start() end

love.load = function()
  
  -- initial load of static data
  require "computer/computerModel"
  require "computer/behaviors"
  
  junk = require "gamestates/game/junk"
  hammer = require "gamestates/game/hammer"
  hammer.load()
  smoke = require "gamestates/game/smoke"
  
  images = {
    monitor = love.graphics.newImage("images/monitor.png"),
    smoke = love.graphics.newImage("images/junk/smoke.png")
  }
  faces = {
    smile = love.graphics.newImage("images/faces/smile.png"),
    wink = love.graphics.newImage("images/faces/wink.png"),
    happy = love.graphics.newImage("images/faces/happy.png"),
    laugh = love.graphics.newImage("images/faces/laugh.png"),
    sad = love.graphics.newImage("images/faces/sad.png"),
    dead = love.graphics.newImage("images/faces/dead.png"),    
    evil = love.graphics.newImage("images/faces/evil.png"),    
    static = love.graphics.newImage("images/faces/static.png"),
    off = love.graphics.newImage("images/faces/off.png"),
  }
  
  looky = require "looky"
  ease = require "easy"  
  layout = require "baselayout"

  -- specific load for a game
  state = require "gamestates/game"()
  state.load()
  
end

love.update = function(dt)
 state:update(dt)
end

love.mousepressed = function(x,y,button)
  state:mousepressed(x,y,button)
end

love.draw = function()
  state:draw()  
end