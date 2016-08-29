return function()
  return {
    load = function(self)
      self.transition = false
      
      root = looky:build("root")
      root:addChild(looky:build("image", { width = "fill", height = "fill", file = images.intro, background = { 255,255,255,255} }))
      root:layoutingPass()
    end,
    update = function(self, dt)
      if self.transition then
        return gameState
      end
    end,
    mousepressed = function(self, x, y, button)
      self.transition = true
    end,
    draw = function(self)
      root:render()
    end,
    unload = function(self)
      
    end
  }
end