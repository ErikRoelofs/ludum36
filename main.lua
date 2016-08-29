if arg[#arg] == "-debug" then debug = true else debug = false end
if debug then require("mobdebug").start() end

love.load = function()
  
  -- initial load of static data
  require "computer/computerModel"
  require "computer/behaviors"
  require "pathing"
  
  junk = require "gamestates/game/junk"
  hammer = require "gamestates/game/hammer"
  hammer.load()
  smoke = require "gamestates/game/smoke"
  messagesListener = require "gamestates/game/messages"  
  
  images = {
    monitor = love.graphics.newImage("images/monitor.png"),
    smoke = love.graphics.newImage("images/junk/smoke.png"),
    win = love.graphics.newImage("images/win.png"),
    lose = love.graphics.newImage("images/lose.png"),
    marker = love.graphics.newImage("images/progress.png"),
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
    ecg = love.graphics.newImage("images/faces/ecg.png"),
  }
  
  messages = {
    bubble = love.graphics.newImage("images/bubble.png"),
    attack = love.graphics.newImage("images/icons/attack.png"),
    babble = love.graphics.newImage("images/icons/babble.png"),
  }
  
  looky = require "looky"
  ease = require "easy"  
  layout = require "baselayout"

  -- register layouts
  looky:registerLayout("computer", require("layouts/computerView")(looky))
  looky:registerLayout("face", require("layouts/face")(looky))
  looky:registerLayout("bubble", require("layouts/comm")(looky))
  looky:registerLayout("commcontrol", require("layouts/commcontrol")(looky))
  looky:registerLayout("progress", require("layouts/progress")(looky))

  -- game states
  gameState = require "gamestates/game"
  menuState = require "gamestates/menu"
  winState = require "gamestates/win"
  loseState = require "gamestates/lose"
  
  state = gameState()
  state.load()
  
end

love.update = function(dt)
 local newState = state:update(dt)
 if newState then
   state:unload()
   state = newState()
   state:load()
  end
end

love.mousepressed = function(x,y,button)
  state:mousepressed(x,y,button)
end

love.keypressed = function(key)
  if key == "q" or key == "escape" then
    love.event.quit()
  end
end

love.draw = function()
  state:draw()  
end