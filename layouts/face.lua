return function(looky)
  return {
    build = function(options)
      local container = looky:build("stack", { width = "wrap", height = "wrap", background = { 255, 0, 0, 255 } })
      container.delay = 0
      
      local face = looky:build("image", {width="wrap", height="wrap", file=faces.smile})
      local monitor = looky:build("image", {width="wrap", height="wrap", file=images.monitor})
      
      container:addChild(monitor)
      container:addChild(face)      
      
      container.setExpression = function(self, expr, duration)        
        self:getChild(2):setImage(faces[expr])        
        if duration ~= nil then
          container.delay = duration
        else
          container.delay = 0
        end
      end
      
      
      container.update = function(self, dt)
        if self.delay > 0 then
          self.delay = self.delay - dt
        
          if self.delay <= 0 then
            self:getChild(2):setImage(faces["smile"])
          end
        end
      end
      
      return container
    end,
    schema = {
    }
  }
end