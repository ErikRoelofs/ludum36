newComputer = function(name, faction, behavior)
  return {
    health = 3,
    maxHealth = 3,
    name = name,
    faction = faction,
    behavior = getBehavior(behavior),
    state = {
      expr = "smile",
      getExpression = function(self)
        return self.expr
      end
    },
    isAlive = function(self)
      return self.health > 0
    end,
    takeHit = function(self)
      self.health = self.health - 1
      if self:isAlive() then
        self.state.expr = "sad"
        return false
      else
        self.state.expr = "dead"
        return true
      end
    end
  }  
end