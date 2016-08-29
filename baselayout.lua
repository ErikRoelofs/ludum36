return function()

  local root = looky:build("stackroot")
    
  local mainscreen = looky:build("linear", { width = "fill", height = "fill", direction = "v" })

  progress = looky:build("progress")

  serverRoomView = looky:build("grid", { rows = rows, columns = columns, width = "fill", height = "fill", padding = looky.padding(100, 10, 10, 10), background = { file = "images/cablebackground2.png", fill = "fit" } })
  for i = 1, rows do
    for j = 1, columns do
      serverRoomView:setChild( looky:build("computer", { model = getComputer(i,j)}), i, j)
    end
  end

  commPane = looky:build("commcontrol")
--  commPane:newMessage("attack", getComputer(1,1), getComputer(1,3))

  overPane = looky:build("freeform", {width = "fill", height="fill", render = renderOvermap})

  mainscreen:addChild(progress)
  mainscreen:addChild(serverRoomView)
  root:addChild(mainscreen)
  root:addChild(commPane)
  root:addChild(overPane)

  root:layoutingPass()

  return root
end