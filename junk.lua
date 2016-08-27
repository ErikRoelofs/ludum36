return {
  load = function()
    junkData = { 
      images = {
        love.graphics.newImage("images/junk/bolt.png"),
        love.graphics.newImage("images/junk/screw.png"),
        love.graphics.newImage("images/junk/nut.png"),
        love.graphics.newImage("images/junk/wingnut.png"),
        
      },
      dx = { 25, 100 },
      dy = { 90, 120 },
      dr = { 10, 30 },
      ay = 600  
    }
    direction = function()
      if math.random(0,1) == 0 then
        return -1
      else
        return 1
      end
    end
    makeJunk = function(x,y,amount)
      for i = 1, amount do
        local junk = {
          x = x + math.random(-20,20),
          y = y + math.random(-20,20),
          dx = direction() * math.random(junkData.dx[1], junkData.dx[2]), 
          dy = -1 * math.random(junkData.dy[1], junkData.dy[2]),
          r = math.random(1,100), 
          dr = direction() * math.random(junkData.dr[1], junkData.dr[2]),
          image = junkData.images[math.random(1, #junkData.images)]
        }
        table.insert(junkItems, junk)
      end
    end
  
    junkItems = {}
    
    root:addListener({ junk = function(self, signal, payload, coords)
      if signal == "smashed" then      
        makeJunk(coords[1].x,coords[1].y,25)
      end
    end}, "junk")

  end,
  update = function(dt)
    for k = #junkItems, 1, -1 do
      local j = junkItems[k]
      j.x = j.x + ( j.dx * dt )
      j.y = j.y + ( j.dy * dt )
      j.dy = j.dy + ( junkData.ay * dt )
      j.r = j.r + ( j.dr * dt )
      if j.y > serverRoomView:grantedHeight() then
        table.remove(junkItems, k)
      end
    end
  end,
  draw = function(dt)
    
  end  
}
  
