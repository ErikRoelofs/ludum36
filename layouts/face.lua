return function(looky)
  return {
    build = function(options)
      local container = looky:build("stack", { width = "wrap", height = "wrap", background = { 255, 0, 0, 255 } })
      
      
      local face = looky:build("image", {width="wrap", height="wrap", file="images/emoticon.png"})
      local monitor = looky:build("image", {width="wrap", height="wrap", file="images/monitor.png"})
      
      container:addChild(monitor)
      container:addChild(face)      
      return container
    end,
    schema = {}
  }
end