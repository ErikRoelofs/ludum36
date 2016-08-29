newComputer = function(name, faction, behavior)
  return {
    health = 3,
    maxHealth = 3,
    name = name,
    faction = faction,
    behavior = getBehavior(behavior),
    update = function(self, dt)      
      self.expr:update(dt)
    end,
    expr = {
      newExpr = function(self, state, duration)
        table.insert(self.stack, { expr = "static", duration = 0.2 })
        table.insert(self.stack, { expr = state, duration = duration })
        table.insert(self.stack, { expr = "static", duration = 0.2 })
      end,
      update = function(self, dt)
        local item = self:currentItem()
        if item.duration ~= "base" then
          item.duration = item.duration - dt
          if item.duration <= 0 then
            self:popExpr()
          end
        end
      end,
      currentItem = function(self)
        return self.stack[#self.stack]
      end,
      currentExpression = function(self)
        return self:currentItem().expr
      end, 
      popExpr = function(self)
        table.remove(self.stack)
      end,
      overrideExpr = function(self, expr)
        self.stack = { {expr = expr, duration = "base"} }
        table.insert(self.stack, { expr = "static", duration = 0.2 })
      end,
      stack = { { expr = "smile", duration = "base" } },
    },
    isAlive = function(self)
      return self.health > 0
    end,
    takeHit = function(self)
      self.health = self.health - 1
      if self:isAlive() then
        self.expr:newExpr( "sad", 1 )
        return false
      else
        self.expr:overrideExpr( "dead" )
        return true
      end
    end,
    getExpression = function(self)
      return self.expr:currentExpression()
    end,

  }  
end