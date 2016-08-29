return function(looky)
  return {
    build = function(options)      
      local case = looky:build("linear", { width = "wrap", height="wrap", direction = "h"})      
      
      local face = looky:build("face", { model = options.model})
      
      local rightSide = looky:build("linear", { width = "wrap", height="wrap", direction = "v"})
      
      local fans = looky:build("image", { width = "wrap", height = "wrap", file = "images/toppane.png" })
      
      local lightsContainer = looky:build("linear", { width = "wrap", height="wrap", direction = "h"})
      local leds = looky:build("image", { width = "wrap", height = "wrap", file = "images/ledspane.png" })
      --local leds = looky:build("text", { width = "wrap", height = "wrap", data = function() return options.model.name end })
      local hearts = looky:build("numberAsImage", { width = 87, height = 30, value = function(self) 
            return options.model.health end, 
      maxValue = options.model.maxHealth, image = "images/heart.png", background = { 70, 70, 70, 255 }})
      
      case:addChild(face)
      case:addChild(rightSide)
      rightSide:addChild(fans)
      rightSide:addChild(lightsContainer)
      lightsContainer:addChild(leds)
      lightsContainer:addChild(hearts)
      
      -- handle twacks
      case.externalSignalHandlers.hit = function(self, signal, payload, coords)
        if payload.type == "hammer" and self:coordsInMe( coords[1].x, coords[1].y ) and options.model:isAlive() then 
          local died = options.model:takeHit()
          if died then
            self:messageOut("croaked", {child = self, faction = options.model.side}, {{x=coords[1].x,y=coords[1].y}})
          end
          self:messageOut("smashed", {child = self}, {{x=coords[1].x,y=coords[1].y}})
        end
      end
      
      return case
            
    end,
    schema = {
      model = {
        required = true,
        schemaType = "table",
        allowOther = true,
        options = {}
      }
    }
  }
end