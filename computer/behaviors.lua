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
        self.delay = love.math.random(200,1500) / 100
      end,
      update = function(self, dt)
        self.delay = self.delay - dt
        if self.delay < 0 then
          self:setWait()
          return {
            msg = "attack",
            origin = self.computer,
            target = pickRandomNonEvilComputer()
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
        self.delay = love.math.random(200,1500) / 100
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