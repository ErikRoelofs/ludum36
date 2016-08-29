-- UGLY: offsetting all coords by 37 to adjust for the height of the speech bubble.

-- [lines][columns]
-- the first item is the connecting bridge
coordinatesX = { 40, 305, 600, 898, 1195, 1497 }
coordinatesY = { 64, 235, 400, 575, 740 }

function getCoordsForBridge(line) 
  return { coordinatesX[1], coordinatesY[line] - 37 }
end

function getCoordsForComputer(line, number)
  return { coordinatesX[number+1], coordinatesY[line] - 37 }
end

function getCoordsForConnector(line, number)
  local coord = getCoordsForComputer(line, number)
  return { coord[1], coord[2] + 40 }
end

function getPathFromComputerToComputer(startLine, startNumber, endLine, endNumber)
  local path = {}
  -- appear on the connector
  table.insert(path, getCoordsForConnector(startLine, startNumber))
  -- start by going up to the mainline
  table.insert(path, getCoordsForComputer(startLine, startNumber))  
  -- if the target computer is on another line
  if startLine ~= endLine then
    -- first travel to the main bridge
    table.insert(path, getCoordsForBridge(startLine))
    -- travel across the bridge to the target line
    table.insert(path, getCoordsForBridge(endLine))
  end
  -- travel to the right computer
  table.insert(path, getCoordsForComputer(endLine, endNumber))
  -- travel down the connector
  table.insert(path, getCoordsForConnector(endLine, endNumber))
  
  return path
end

