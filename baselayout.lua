return function()

  local root = looky:build("stackroot")
    
  local mainscreen = looky:build("linear", { width = "fill", height = "fill", direction = "v" })

  progress = looky:build("numberAsBar", { width = "fill", height = 50, value = function() return victory:currentProgress() end, maxValue = 100, filledColor = { 255, 0, 0, 255 }, background = { 0, 0, 255, 255 }})

  serverRoomView = looky:build("grid", { rows = rows, columns = columns, width = "fill", height = "fill", padding = looky.padding(100, 10, 10, 10), background = { file = "images/cablebackground.png", fill = "fit" } })
  for i = 1, rows do
    for j = 1, columns do
      serverRoomView:setChild( looky:build("computer", { model = getComputer(i,j)}), i, j)
    end
  end

  local commPane = looky:build("commcontrol")
  commPane:newMessage("attack", getComputer(1,1), getComputer(1,3))
  --commPane:newMessage("attack", getComputer(2,3), getComputer(3,4))
  --commPane:newMessage("attack", getComputer(4,5), getComputer(2,3))

  overPane = looky:build("freeform", {width = "fill", height="fill", render = renderOvermap})

  mainscreen:addChild(progress)
  mainscreen:addChild(serverRoomView)
  root:addChild(mainscreen)
  root:addChild(commPane)
  root:addChild(overPane)

  root:layoutingPass()

  return root
end