return function(looky)
  return {
    build = function(options)
      local container = looky:build("linear", { width = "fill", height = 50, direction = "h", background = { 120, 120, 120, 255 } })
      container:addChild(looky:build("image", { width = 66, height = 50, file = images.win, scale = "fit" }))
      
      local stack = looky:build("stack", { width = "fill", height = 50 })
        
      local function renderMarker(self)
        love.graphics.setColor(255,255,255,255)
        love.graphics.draw(images.marker, (victory:currentProgress() / 100) * self:grantedWidth() - images.marker:getWidth() / 2 ,0)
      end
      local bar = looky:build("numberAsBar", { width = "fill", height = 50, value = function() return victory:currentProgress() end, maxValue = 100, filledColor = { 255, 0, 0, 255 }, background = { 0, 0, 255, 255 }})
      stack:addChild(bar)
      stack:addChild(looky:build("freeform", { width = "fill", height = 50, render = renderMarker }))
      
      container:addChild(stack)
      
      container:addChild(looky:build("image", { width = 66, height = 50, file = images.lose, scale = "fit" }))
      
      return container
    end,
    schema = {}
  }
end

