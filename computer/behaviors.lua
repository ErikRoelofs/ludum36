getBehavior = function(computer, behavior)
  return {
    computer = computer,
    update = function(self, dt)
      if math.random(1,1000) == 1 then
        return {
          msg = "attack",
          origin = self.computer,
          target = getComputer(3,3)
        }
      end
    end,    
  }
end