return function(looky)
  return {
    build = function(options)      
      local case = looky:build("linear", { width = "wrap", height="wrap", direction = "h"})      
      case.health = 3
      
      local face = looky:build("face")
      
      local rightSide = looky:build("linear", { width = "wrap", height="wrap", direction = "v"})
      
      local fans = looky:build("image", { width = "wrap", height = "wrap", file = "images/toppane.png" })
      
      local lightsContainer = looky:build("linear", { width = "wrap", height="wrap", direction = "h"})
      local leds = looky:build("image", { width = "wrap", height = "wrap", file = "images/ledspane.png" })
      local hearts = looky:build("numberAsImage", { width = 87, height = 30, value = function(self) 
            return case.health end, 
      maxValue = 3, image = "images/heart.png", background = { 70, 70, 70, 255 }})
      
      case:addChild(face)
      case:addChild(rightSide)
      rightSide:addChild(fans)
      rightSide:addChild(lightsContainer)
      lightsContainer:addChild(leds)
      lightsContainer:addChild(hearts)
      
      -- handle twacks
      case.externalSignalHandlers.hit = function(self, signal, payload, coords)
        if payload.type == "hammer" and self:coordsInMe( coords[1].x, coords[1].y ) and self.health > 0 then 
          self.health = self.health - 1
          if self.health == 0 then
            face:setExpression("dead")
          else
            face:setExpression("sad", 1)
          end
          self:messageOut("smashed", {child = self}, coords)
        end
      end
      
      return case
            
    end,
    schema = {}
  }
end