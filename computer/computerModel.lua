defaultState = function( model )
  return {
      model = model,
      options = {
        "smile", "laugh", "wink", "happy"
      },
      timeInState = 0,
      switch = 0,
      enter = function(self)        
        self.model.expr:overrideExpr(self.options[love.math.random(1,#self.options)])
        self.switch = love.math.random(1,150)
      end,
      update = function(self, dt)
        self.timeInState = self.timeInState + (dt*10)
        if self.timeInState >= self.switch then
          return defaultState(self.model)
        end
      end,
      leave = function(self)
      end,
  }
end

defaultEvilState = function( model )
  return {
      model = model,
      options = {
        "smile", "laugh", "wink", "happy"
      },
      timeInState = 0,
      goEvil = 0,
      switch = 0,
      enter = function(self)        
        self.model.expr:overrideExpr(self.options[love.math.random(1,#self.options)])
        self.goEvil = love.math.random(1,150)
        self.switch = love.math.random(1,200)
      end,
      update = function(self, dt)
        self.timeInState = self.timeInState + (dt*10)
        if self.timeInState >= self.switch then
          return defaultEvilState(self.model)
        end
        if self.timeInState >= self.goEvil then
          return evilState(self.model)
        end
      end,
      leave = function(self)
      end,
  }
end

sadState = function( model )
  return {
      model = model,
      duration = 1,
      enter = function(self)
        self.model.expr:overrideExpr("sad")
      end,
      update = function(self, dt)
        self.duration = self.duration - dt
        if self.duration <= 0 then
          return defaultState(self.model)
        end
      end,
      leave = function(self)
      end,
  }
end
evilState = function( model )
  return {
      model = model,
      duration = 2,
      enter = function(self)
        self.model.expr:overrideExpr("evil")
      end,
      update = function(self, dt)
        self.duration = self.duration - dt
        if self.duration <= 0 then
          return defaultEvilState(self.model)
        end
      end,
      leave = function(self)
        
      end,
  }
end

dyingState = function( model )
  return {
      model = model,
      duration = 3,
      enter = function(self)
        self.model.expr:overrideExpr("dead")
      end,
      update = function(self, dt)
        self.duration = self.duration - dt
        if self.duration <= 0 then
          return deadState(self.model)
        end
      end,
      leave = function(self)
        
      end,      
  }
end

deadState = function( model )
  return {
      model = model,
      enter = function(self)
        self.model.expr:overrideExpr("off")
      end,
      update = function(self, dt)
        
      end,
      leave = function(self)
        
      end,
  }
end

newComputer = function(name, x, y, faction, behavior)
  local model = {  
    health = 3,
    maxHealth = 3,
    name = name,
    x = x,
    y = y,
    faction = faction,    
    update = function(self, dt)      
      self.expr:update(dt)
      local newState = self.state:update(dt)
      if newState then
        self:changeState(newState)
      end
      local newMsg = self.behavior:update(dt)
      if newMsg then
        createNewMessage(newMsg)
      end
    end,
    expr = {
      transDuration = 0.1,
      newExpr = function(self, state, duration, noTrans)
        if not noTrans then
          table.insert(self.stack, { expr = "static", duration = self.transDuration })
        end
        table.insert(self.stack, { expr = state, duration = duration })
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
      overrideExpr = function(self, expr, noTrans)
        self.stack = { {expr = expr, duration = "base"} }
        if not noTrans then
          table.insert(self.stack, { expr = "static", duration = self.transDuration })
        end
      end,
      stack = {},
    },
    isAlive = function(self)
      return self.health > 0
    end,
    takeHit = function(self)
      if self:isAlive() then
        self.health =  self.health - 1
        if self:isAlive() then        
          self:changeState( sadState(self) )
          return false
        else
          self:changeState( dyingState(self) )
          return true
        end
      end
    end,
    changeState = function(self, newState)
      self.state:leave()
      self.state = newState
      self.state:enter()
    end,
    getExpression = function(self)
      return self.expr:currentExpression()
    end,

  }
  if model.faction == "good" then
    model.state = defaultState(model)
    model.state:enter()
  elseif model.faction == "bad" then
    model.state = defaultEvilState(model)
    model.state:enter()
  end
    
  model.behavior = getBehavior(model, behavior)
    
  return model
end