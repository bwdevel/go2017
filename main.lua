function love.load()
  debug = false
  grid = {}
  grid[1] = {1, 1, 1, 1, 1, 1, 1, 1, 1}
  grid[2] = {1, 0, 0, 0, 0, 0, 0, 1, 1}
  grid[3] = {1, 1, 0, 1, 0, 1, 0, 0, 1}
  grid[4] = {1, 1, 0, 1, 1, 1, 0, 1, 1}
  grid[5] = {1, 1, 0, 1, 0, 0, 0, 1, 1}
  grid[6] = {1, 0, 0, 0, 0, 0, 0, 0, 1}
  grid[7] = {1, 0, 1, 1, 0, 1, 1, 0, 1}
  grid[8] = {1, 0, 0, 0, 0, 0, 0, 0, 1}
  grid[9] = {1, 1, 1, 1, 1, 1, 1, 1, 1}
  player = {}
  player.d = 0
  player.x = 6
  player.y = 3
  player.rot = 1
  arrow = love.graphics.newImage('assets/img/arrow_01.png')
  rotations = {0, (math.pi * 2) / 4, math.pi, math.pi + math.pi / 2}

end

function love.update(dt)


end

function love.draw()
  grid_draw()
  view_draw()
  if debug then debug_draw() end
end

function love.keyreleased(key)
  if key == 'escape' then love.event.quit() end
  if key == 'p' then
    if debug then debug = false else debug = true end
  end
  if key == 'd' then
    if grid[player.x + 1][player.y] == 0 then
      player.x = player.x + 1
    end
  end
  if key == 'w' then
    if grid[player.x][player.y - 1] == 0 then
      player.y = player.y - 1
    end
  end
  if key == 'a' then
    if grid[player.x - 1][player.y] == 0 then
      player.x = player.x - 1
    end
  end
  if key == 's' then
    if grid[player.x][player.y + 1] == 0 then
      player.y = player.y + 1
    end
  end
  if key == 'q' then
    player.rot = player.rot - 1
    if player.rot < 1 then player.rot = 4 end
  end
  if key == 'e' then
    player.rot = player.rot + 1
    if player.rot > 4 then player.rot = 1 end
  end
end

function debug_draw()
  local x = 10
  local y = 10
  local w = 100
  local h = 50
  love.graphics.setColor(0, 0, 0, 128)
  love.graphics.rectangle('fill', x, y, w, h)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.rectangle('line', x, y, w, h)
  love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), x + 2, y + 2)
  love.graphics.print('Player x/y: ' .. tostring(player.x) .. '/' .. tostring(player.y), x + 2, y + 14)
  love.graphics.print('Current Sqr Val: ' .. tostring(grid[player.x][player.y]), x + 2, y + 26)
  love.graphics.print('Player Rot: ' .. tostring(player.rot) .. '(' .. tostring(rotations[player.rot]) .. ')', x + 2, y + 38)
end

function grid_draw()
  love.graphics.setColor(0, 0, 255, 255)
  for x = 1, #grid, 1 do
    for y = 1, #grid[x], 1 do
      local xx = (x - 1) * 16 + 800
      local yy = (y - 1) * 16 + 250
      local fill = 'line'
      if grid[x][y] == 1 then fill = 'fill' end
      love.graphics.rectangle(fill, xx, yy, 16, 16)
      if x == player.x and y == player.y then
        love.graphics.setColor(255, 255, 255, 255)
        --love.graphics.rectangle('fill', xx + 2, yy + 2, 12, 12)
        love.graphics.draw(arrow, xx + 2 + 7, yy + 2 + 7, rotations[player.rot], 1, 1, 7 , 7)
        love.graphics.setColor(0, 0, 255, 255)
      end
    end
  end
end

function view_draw()
  local xx = 100
  local yy = love.graphics.getHeight() / 2 - 512 / 2
  local ww = 512
  local hh = 512
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.rectangle('line', xx, yy, ww, hh)

  -- draw left
  if grid[player.x - 1][player.y] == 1 then
    local x1 = xx
    local y1 = yy
    local x2 = xx + ww / 4
    local y2 = yy + hh / 4
    local x3 = xx + ww / 4
    local y3 = yy + hh - hh / 4
    local x4 = xx
    local y4 = yy + hh
    love.graphics.line(x1, y1, x2, y2, x3, y3, x4, y4)
  end
  -- draw right
  if grid[player.x + 1][player.y] == 1 then
    local x1 = xx + ww
    local y1 = yy
    local x2 = x1 - ww / 4
    local y2 = yy + hh / 4
    local x3 = x2
    local y3 = yy + hh - hh / 4
    local x4 = x1
    local y4 = yy + hh
    love.graphics.line(x1, y1, x2, y2, x3, y3, x4, y4)
  end

  -- draw left far
  if grid[player.x - 1][player.y - 1] == 1 and grid[player.x][player.y - 1] == 0 then
    local x1 = xx + ww / 4
    local y1 = yy + hh / 4
    local x2 = xx + ww / 4 + ww / 8
    local y2 = yy + hh / 4 + hh / 8
    local x3 = x2
    local y3 = y2 + hh / 4
    local x4 = x1
    local y4 = yy + hh - hh / 4
    love.graphics.line(x1, y1, x2, y2, x3, y3, x4, y4)
  end
  -- draw right far
  if grid[player.x + 1][player.y - 1] == 1 and grid[player.x][player.y - 1] == 0 then
    local x1 = xx + ww / 2 + ww / 4
    local y1 = yy + hh / 4
    local x2 = xx + ww / 2 + ww / 8
    local y2 = yy + hh / 4 + hh / 8
    local x3 = x2
    local y3 = y2 + hh / 4
    local x4 = x1
    local y4 = yy + hh - hh / 4
    love.graphics.line(x1, y1, x2, y2, x3, y3, x4, y4)
  end




  -- draw front center
  if grid[player.x][player.y - 1] == 1 then
    local x1 = xx + ww / 4
    local y1 = yy + hh / 4
    local w1 = ww / 2
    local h1 = hh / 2
    love.graphics.rectangle('line', x1, y1, w1, h1)
  end
  -- draw font left
  if grid[player.x - 1][player.y -1] == 1 and grid[player.x - 1][player.y] == 0 then
    local x1 = xx
    local y1 = yy + hh / 4
    local w1 = ww / 4
    local h1 = hh / 2
    love.graphics.rectangle('line', x1, y1, w1, h1)
  end
  -- draw font left
  if grid[player.x + 1][player.y -1] == 1 and grid[player.x + 1][player.y] == 0 then
    local x1 = xx + ww - ww / 4
    local y1 = yy + hh / 4
    local w1 = ww / 4
    local h1 = hh / 2
    love.graphics.rectangle('line', x1, y1, w1, h1)
  end
  -- draw front center far
  if grid[player.x][player.y - 2] == 1 and grid[player.x][player.y - 1] == 0 then
    local x1 = xx + ww / 4 + ww / 8
    local y1 = yy + hh / 4 + ww / 8
    local w1 = ww / 4
    local h1 = hh / 4
    love.graphics.rectangle('line', x1, y1, w1, h1)
  end

end
