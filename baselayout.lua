looky:registerLayout("computer", require("layouts/computer")(looky))
looky:registerLayout("face", require("layouts/face")(looky))

local root = looky:build("stackroot")
  
serverRoomView = looky:build("grid", { rows = 4, columns = 4, width = "fill", height = "fill", padding = looky.padding(25), background = { 45, 35, 35, 255 } })
for i = 1, 4 do
  for j = 1, 4 do
    serverRoomView:setChild( looky:build("computer"), i, j)
  end
end


hammerPane = looky:build("freeform", {width = "fill", height="fill", render = renderHammer})

root:addChild(serverRoomView)
root:addChild(hammerPane)

return root