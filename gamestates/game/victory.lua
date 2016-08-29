return function()
  local victory = 
  {
    animLength = 0.5,
    getBadComputerCount = function()  
      local bad = 0
      for i = 1, #computers do
        if computers[i]:isAlive() and computers[i].faction == "bad" then
          bad = bad + 1
        end
      end
      return bad
    end,
    getGoodComputerCount = function()  
      local good = 0
      for i = 1, #computers do
        if computers[i]:isAlive() and computers[i].faction == "good" then
          good = good + 1
        end
      end
      return good
    end,
    load = function(self)
      self.current = self:target()
      self.start = self:target()
      self.goal = self:target()
      self.progress = 0
    end,
    target = function(self)
      local goodSmashed = self.initialGoodComputerCount - self.getGoodComputerCount()
      local badSmashed = self.initialBadComputerCount - self.getBadComputerCount()
      local badLeft = self.getBadComputerCount()
      local margin = 3 + math.floor( badSmashed / 3 )
      local marginLeft = margin - goodSmashed
      
      return math.min((badLeft / (badLeft + marginLeft)) * 100, 100)
    end,    
    currentProgress = function(self)
      return self.current
    end,
    update = function(self, dt)
      if self:target() ~= self.goal then
        self.progress = 0
        self.start = self.goal
        self.goal = self:target()
      end
      if self.progress < 1 then
        self.progress = self.progress + ( dt / self.animLength )
        self.current = self.start + ( ease('quintin', self.progress ) * ( self.goal - self.start ) )
      end          
    end,
    hasWon = function(self)
      return self.getBadComputerCount() == 0
    end,
    hasLost = function(self)
      return self:target() == 100
    end,
  }
   
  victory.initialBadComputerCount = victory.getBadComputerCount()
  victory.initialGoodComputerCount = victory.getGoodComputerCount()

  return victory
end