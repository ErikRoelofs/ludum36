return {
  load = function()
    smokeItems = {}
    
    makeSmoke = function(x,y, faction)
      
      local psystem = love.graphics.newParticleSystem(images.smoke, 32)
      psystem:setParticleLifetime(1, 2)
      psystem:setEmitterLifetime(5)
      psystem:setEmissionRate(15)
      psystem:setSizeVariation(1)
      psystem:setAreaSpread("uniform", 75, 10)
      psystem:setLinearAcceleration(-100, -100, 100, -50) -- Random movement in all directions.
      psystem:setRadialAcceleration(0,2)	
      if faction == "bad" then
        psystem:setColors(80, 80, 80, 200, 80, 80, 80, 100) -- Fade to transparency.
      else
        psystem:setColors(220, 220, 220, 200, 220, 220, 220, 100) -- Fade to transparency.
      end
      psystem:setSizes( 0.5, 2 )
           
      local smoke = {
        ps = psystem,
        x = x,
        y = y,
        duration = 10
      }
      table.insert(smokeItems, smoke)
    end
    
    root:addListener({ smoke = function(self, signal, payload, coords)
      if signal == "croaked" then      
        makeSmoke(coords[1].x,coords[1].y, payload.faction)
      end
    end}, "smoke")

  end,
  update = function(dt)
    for _, smoke in ipairs(smokeItems) do
      smoke.ps:update(dt)
      smoke.duration = smoke.duration - dt
    end
    
    for i = #smokeItems, 1, -1 do
      if smokeItems[i].duration < 0 then
        smokeItems[i].ps:stop()
        table.remove(smokeItems, i)
      end
    end
  end,
  
}