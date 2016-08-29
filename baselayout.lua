looky:registerLayout("computer", require("layouts/computerView")(looky))
looky:registerLayout("face", require("layouts/face")(looky))

local root = looky:build("stackroot")
  
local mainscreen = looky:build("linear", { width = "fill", height = "fill", direction = "v" })

progress = looky:build("numberAsBar", { width = "fill", height = 50, value = getBadComputerCount, maxValue = getTotalComputerCount, filledColor = { 255, 0, 0, 255 }, background = { 0, 0, 255, 255 }})

serverRoomView = looky:build("grid", { rows = rows, columns = columns, width = "fill", height = "fill", padding = looky.padding(25), background = { 45, 35, 35, 255 } })
for i = 1, rows do
  for j = 1, columns do
    serverRoomView:setChild( looky:build("computer", { model = getComputer(i,j)}), i, j)
  end
end


overPane = looky:build("freeform", {width = "fill", height="fill", render = renderOvermap})

mainscreen:addChild(progress)
mainscreen:addChild(serverRoomView)
root:addChild(mainscreen)
root:addChild(overPane)

return root