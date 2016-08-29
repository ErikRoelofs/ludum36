return function(looky)
  return {
    build = function(options)
      local container = looky:build("aquarium", { width = "fill", height = "fill"})
      container.childSpeed = {
          slow = 50,
          fast = 400,
      }
      
      function container:newMessage(msg, from, to)
        local path = getPathFromComputerToComputer(from.y, from.x, to.y, to.x)
        local x, y = path[1][1], path[1][2]
        self:addChild(looky:build("bubble", { target = to, msg = msg, path = path}),x,y)
        self:layoutingPass()
      end
    
      function container:update(dt)
        
        for i, c in ipairs(self:getChildren()) do
          
          local x, y = self:getOffset(c)
          local targetX, targetY, spd = c.path[1][1], c.path[1][2], c.path[1][3]
          
          if x == targetX and y == targetY and #c.path == 1 then
            -- done! deliver the message and drop the bubble
            self:messageOut("msg", { msg = c.msg, target = c.target})
            self:removeChild(c)
          else          
            -- if we reached the current node, pop the first item from the path
            if x == targetX and y == targetY then
              table.remove(c.path, 1)
              -- get the new target
              targetX, targetY, spd = c.path[1][1], c.path[1][2], c.path[1][3]
            end
            
            -- move closer to our (new) target
            if x < targetX then
              x = math.min( x + self.childSpeed[spd] * dt, targetX )
            end
            if x > targetX then
              x = math.max( x - self.childSpeed[spd] * dt, targetX )
            end
            
            if y < targetY then
              y = math.min( y + self.childSpeed[spd] * dt, targetY )
            end
            if y > targetY then
              y = math.max( y - self.childSpeed[spd] * dt, targetY )
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