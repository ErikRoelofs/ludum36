return {
  load = function()
      hammerModel = {
      image = love.graphics.newImage("images/hammer.png"),
      x = 0,
      y = 0,
      smashing = false,
      progress = 0,
    }
    
  end,
  update = function(dt)
    hammerModel.x, hammerModel.y = love.mouse.getPosition()    
    root:update(dt)
    
    if hammerModel.smashing == "down" then
      hammerModel.progress = hammerModel.progress + (dt*5)
      hammerModel.r = -ease("quintin", hammerModel.progress) * (math.pi / 2)
      if hammerModel.progress > 1 then
        hammerModel.smashing = "up"
        hammerModel.progress = 0  
        root:receiveOutsideSignal("hit", { type = "hammer" }, { { x = hammerModel.x - 85, y = hammerModel.y + 20} })
      end
    end
    
    if hammerModel.smashing == "up" then
      hammerModel.progress = hammerModel.progress + (dt*3) 
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