return function(looky)
  return {
    build = function(options)
      local container = looky:build("aquarium", { width = "fill", height = "fill"})
      container.childSpeed = 200
      
      function container:newMessage(msg, from, to)
        local path = getPathFromComputerToComputer(from.y, from.x, to.y, to.x)
        local x, y = path[1][1], path[1][2]
        self:addChild(looky:build("bubble", { target = to, msg = msg, path = path}),x,y)
      end
    
      function container:update(dt)
        
        for i, c in ipairs(self:getChildren()) do
          
          local x, y = self:getOffset(c)
          local targetX, targetY = c.path[1][1], c.path[1][2]
          
          if x == targetX and y == targetY and #c.path == 1 then
            -- done! deliver the message and drop the bubble
            self:messageOut("msg", { msg = c.msg, target = c.target})
            self:removeChild(c)
          else          
            -- if we reached the current node, pop the first item from the path
            if x == targetX and y == targetY then
              table.remove(c.path, 1)
              -- get the new target
              targetX, targetY = c.path[1][1], c.path[1][2]
            end
            
            -- move closer to our (new) target
            if x < targetX then
              x = math.min( x + self.childSpeed * dt, targetX )
            end
            if x > targetX then
              x = math.max( x - self.childSpeed * dt, targetX )
            end
            
            if y < targetY then
              y = math.min( y + self.childSpeed * dt, targetY )
            end
            if y > targetY then
              y = math.max( y - self.childSpeed * dt, targetY )
            end
            
            -- actually move the child
            self:setOffset(c,x,y)
          end
        end
      end
    
      return container
    end,
    schema = {      
    }
  }
end