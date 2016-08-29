createNewMessage = function(msg)
  commPane:newMessage(msg.msg, msg.origin, msg.target)
end

return {
  load = function()
    root:addListener({ message = function(self, signal, payload, coords)
      if signal == "msg" then              
        payload.target:takeHit()
      end          
    end}, "message")

  end,  
}