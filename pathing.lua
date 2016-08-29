-- UGLY: offsetting all coords by 37 to adjust for the height of the speech bubble.

-- [lines][columns]
-- the first item is the connecting bridge
coordinatesX = { 40, 305, 600, 898, 1195, 1497 }
coordinatesY = { 64, 235, 400, 575, 740 }

local function getCoordsForBridge(line) 
  return { coordinatesX[1], coordinatesY[line] - 37}
end

local function getCoordsForComputer(line, number)
  return { coordinatesX[number+1], coordinatesY[line] - 37}
end

local function getCoordsForConnector(line, number)
  local coord = getCoordsForComputer(line, number)
  return { coord[1], coord[2] + 40 }
end

local function addPathPartWithSpeed(coords, speed)
  return { coords[1], coords[2], speed }
end

function getPathFromComputerToComputer(startLine, startNumber, endLine, endNumber)
  local path = {}
  -- appear on the connector
  table.insert(path, addPathPartWithSpeed(getCoordsForConnector(startLine, startNumber), "start"))
  -- start by going up to the mainline
  table.insert(path, addPathPartWithSpeed(getCoordsForComputer(startLine, startNumber), "slow"))  
  -- if the target computer is on another line
  if startLine ~= endLine then
    -- first travel to the main bridge
    table.insert(path, addPathPartWithSpeed(getCoordsForBridge(startLine), "fast"))
    -- travel across the bridge to the target line
    table.insert(path, addPathPartWithSpeed(getCoordsForBridge(endLine), "fast"))
  end
  -- travel to the right computer
  table.insert(path, addPathPartWithSpeed(getCoordsForComputer(endLine, endNumber), "fast"))
  -- travel down the connector
  table.insert(path, addPathPartWithSpeed(getCoordsForConnector(endLine, endNumber), "slow"))
  
  return path
end

