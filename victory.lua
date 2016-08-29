
getBadComputerCount = function()  
  local bad = 0
  for i = 1, #computers do
    if computers[i]:isAlive() and computers[i].faction == "bad" then
      bad = bad + 1
    end
  end
  return bad
end

getTotalComputerCount = function()
  local total = 0
  for i = 1, #computers do
    if computers[i]:isAlive() then
      total = total + 1
    end
  end
  return total  
end