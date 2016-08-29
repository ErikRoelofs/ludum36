return function(looky)
  return {
    build = function(options)
      local container = looky:build("stack", { width = "wrap", height = "wrap", background = { 255, 0, 0, 255 } })
      container.state = options.state
      
      local face = looky:build("image", {width="wrap", height="wrap", file=faces.smile})
      local monitor = looky:build("image", {width="wrap", height="wrap", file=images.monitor})
      
      container:addChild(monitor)
      container:addChild(face)      
      
      container.setExpression = function(self, expr)
          self:getChild(2):setImage(faces[expr])        
      end
      
      container.update = function(self, dt)
        expr = self.state:getExpression()
        if self.curExpr ~= expr then
          self.curExpr = expr
          self:getChild(2):setImage(faces[expr])
        end
      end
      
      return container
    end,
    schema = {
      state = {
        required = true,
        schemaType = "table",
        options = {},
        allowOther = true
      }
    }
  }
end