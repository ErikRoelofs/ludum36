return {
  load = function()
    print("loaded")
    root:addListener({ message = function(self, signal, payload, coords)
      print( "listening :D")
      print(signal)
      if signal == "msg" then      
        print("sending hit")
        payload.target:takeHit()
      end
    end}, "message")

  end,  
}
  
