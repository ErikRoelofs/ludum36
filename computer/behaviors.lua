pickRandomComputer = function()
  local pot = {}
  for _, c in ipairs(computers) do
    if c:isAlive() then
      table.insert(pot, c)
    end
  end
  return pot[ love.math.random( 1, #pot ) ]
end

pickRandomNonEvilComputer = function()
  local pot = {}
  for _, c in ipairs(computers) do
    if c.faction ~= "bad" and c:isAlive() then
      table.insert(pot, c)
    end
  end
  return pot[ love.math.random( 1, #pot ) ]
end
  
local behaviors = {
  standardevil = function() 
    return {      
      delay = 0,
      load = function(self)
        self:setWait()
      end,
      setWait = function(self)
        self.delay = love.math.random(200,1000) / 100
      end,
      update = function(self, dt)
        self.delay = self.delay - dt
        if self.delay < 0 then
          self:setWait()          
          local msg = "attack"
          if love.math.random(1,3) == 1 then
            msg = "babble"
          end
          local target
          if love.math.random(1,3) == 3 then
            target = pickRandomComputer()
          else
            target = pickRandomNonEvilComputer()
          end
          return {
            msg = msg,
            origin = self.computer,
            target = target
          }        
        end      
      end,    
    } 
  end,
  passivegood = function() 
    return {
      delay = 0,
      load = function(self)
        self:setWait()
      end,
      setWait = function(self)
        self.delay = love.math.random(200,1000) / 100
      end,
      update = function(self, dt)
        self.delay = self.delay - dt
        if self.delay < 0 then
          self:setWait()
          return {
            msg = "babble",
            origin = self.computer,
            target = pickRandomComputer()
          }        
        end      
      end,                
    } 
  end
}

getBehavior = function(computer, behavior)
  local temp = behaviors[behavior]()
  temp:load()
  temp.computer = computer
  return temp
end