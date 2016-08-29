
getBadComputerCount = function()  
  local bad = 0
  for i = 1, #computers do
    if computers[i]:isAlive() and computers[i].faction == "bad" then
      bad = bad + 1
    end
  end
  return bad
end

getGoodComputerCount = function()  
  local good = 0
  for i = 1, #computers do
    if computers[i]:isAlive() and computers[i].faction == "good" then
      good = good + 1
    end
  end
  return good
end

return 
{
  initialBadComputerCount = getBadComputerCount(),
  initialGoodComputerCount = getGoodComputerCount(),
  animLength = 0.5,
  load = function(self)
    self.current = self:target()
    self.start = self:target()
    self.goal = self:target()
    self.progress = 0
  end,
  target = function(self)
    local goodSmashed = self.initialGoodComputerCount - getGoodComputerCount()
    local badSmashed = self.initialBadComputerCount - getBadComputerCount()
    local badLeft = getBadComputerCount()
    local margin = 3 + math.floor( badSmashed / 3 )
    local marginLeft = margin - goodSmashed
    
    local out = (badLeft / (badLeft + marginLeft)) * 100
    --print(out)
    return out
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
  end
 }