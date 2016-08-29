looky:registerLayout("computer", require("layouts/computerView")(looky))
looky:registerLayout("face", require("layouts/face")(looky))

local root = looky:build("stackroot")
  
serverRoomView = looky:build("grid", { rows = rows, columns = columns, width = "fill", height = "fill", padding = looky.padding(25), background = { 45, 35, 35, 255 } })
for i = 1, rows do
  for j = 1, columns do
    serverRoomView:setChild( looky:build("computer", { model = getComputer(i,j)}), i, j)
  end
end


overPane = looky:build("freeform", {width = "fill", height="fill", render = renderOvermap})

root:addChild(serverRoomView)
root:addChild(overPane)

return root