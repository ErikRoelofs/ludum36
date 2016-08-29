return function()
  return {
    transitionState = nil,
    transitionTime = 0,
    transitioning = false,
    load = function(self)
      rows = 5
      columns = 5
      computers = {}
      
      for i = 1, rows do
        for j = 1, columns do
          local faction = "bad"
          if love.math.random(0,1) == 1 then
            faction = "good"
          end
          table.insert(computers, newComputer("(" .. i .. "," .. j .. ")", faction))
        end
      end

      getComputer = function(i,j)
        return computers[i + ((j-1) * columns)]
      end
      
      victory = require "gamestates/game/victory"()  
      victory:load()

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

      root = layout()

      
      junk.load()
      smoke.load()
    end,
    update = function(self, dt)
      junk.update(dt)
      hammer:update(dt)
      smoke.update(dt)
      
      for i = 1, rows * columns do 
        computers[i]:update(dt)
      end
      
      victory:update(dt)
      
      if not self.transitioning then
        if victory:hasWon() then
          self.transitioning = true
          self.transitionTime = 3
          self.transitionState = winState
        end
        if victory:hasLost() then
          self.transitioning = true
          self.transitionTime = 3
          self.transitionState = loseState
        end
      end
      
      if self.transitioning then
        self.transitionTime = self.transitionTime - dt
        if self.transitionTime < 0 then
          return self.transitionState
        end
      end
    end,
    mousepressed = function(self, x, y, button)
      if not self.transitioning then
        hammer.mousepressed(x,y,button)
      end
    end,
    draw = function(self)
      root:render()
    end,
    unload = function(self)
      
    end
  }
end