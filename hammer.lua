return {
  animDown = 0.1,
  animUp = 0.05,
  load = function()
      hammerModel = {
      image = love.graphics.newImage("images/hammer.png"),
      x = 0,
      y = 0,
      smashing = false,
      progress = 0,
    }
    
  end,
  update = function(self, dt)
    local x, y= love.mouse.getPosition()    
    hammerModel.x = x + 85
    hammerModel.y = y - 20
    root:update(dt)
    
    if hammerModel.smashing == "down" then
      hammerModel.progress = hammerModel.progress + (dt / self.animDown)
      hammerModel.r = -ease("quintin", hammerModel.progress) * (math.pi / 2)
      if hammerModel.progress > 1 then
        hammerModel.smashing = "up"
        hammerModel.progress = 0  
        root:receiveOutsideSignal("hit", { type = "hammer" }, { { x = x, y = y} })
      end
    end
    
    if hammerModel.smashing == "up" then
      hammerModel.progress = hammerModel.progress + (dt / self.animUp) 
      hammerModel.r = (ease("circinout", hammerModel.progress) - 1) * (math.pi/2)
      if hammerModel.progress > 1 then
        hammerModel.smashing = nil
        hammerModel.progress = 0
        hammerModel.r = 0
      end
    end
  end,
  mousepressed = function()    
    if not hammerModel.smashing then
      hammerModel.smashing = "down"  
    end
  end
}