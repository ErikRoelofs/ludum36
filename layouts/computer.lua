return function(looky)
  return {
    build = function(options)
      local case = looky:build("linear", { width = "wrap", height="wrap", direction = "h"})
      
      local face = looky:build("face")
      
      local rightSide = looky:build("linear", { width = "wrap", height="wrap", direction = "v"})
      
      local fans = looky:build("image", { width = "wrap", height = "wrap", file = "images/toppane.png" })
      
      local lightsContainer = looky:build("linear", { width = "wrap", height="wrap", direction = "h"})
      local leds = looky:build("image", { width = "wrap", height = "wrap", file = "images/ledspane.png" })
      local hearts = looky:build("numberAsImage", { width = 87, height = 30, value = function() return 3 end, maxValue = 3, image = "images/heart.png", background = { 70, 70, 70, 255 }})
      
      case:addChild(face)
      case:addChild(rightSide)
      rightSide:addChild(fans)
      rightSide:addChild(lightsContainer)
      lightsContainer:addChild(leds)
      lightsContainer:addChild(hearts)
      
      return case
            
    end,
    schema = {}
  }
end