function love.load()
  love.filesystem.setIdentity('screenshots')
  debug = false
  grid = {}
  grid[1] = {1, 1, 1, 1, 1, 1, 1, 1, 1}
  grid[2] = {1, 0, 0, 0, 0, 0, 0, 1, 1}
  grid[3] = {1, 1, 0, 1, 0, 1, 0, 0, 1}
  grid[4] = {1, 1, 0, 1, 1, 1, 0, 1, 1}
  grid[5] = {1, 1, 0, 1, 0, 0, 0, 1, 1}
  grid[6] = {1, 0, 0, 0, 0, 0, 0, 0, 1}
  grid[7] = {1, 0, 1, 0, 0, 1, 1, 0, 1}
  grid[8] = {1, 0, 0, 0, 0, 0, 0, 0, 1}
  grid[9] = {1, 0, 1, 1, 1, 1, 1, 0, 1}
  grid[10] = {1, 0, 0, 0, 0, 0, 0, 0, 1}
  grid[11] = {1, 1, 1, 1, 1, 1, 1, 1, 1}
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
  if key == 'printscreen' then
    local screenshot = love.graphics.newScreenshot()
    local filename = tostring(os.time()) .. '.png'
    print("Creating screenshot: " .. filename)
    screenshot:encode('png', filename)
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
  -- draw floor and ceiling
  love.graphics.setColor(24, 24, 24, 255)
  love.graphics.rectangle('fill', xx, yy, ww, hh / 2)
  love.graphics.setColor(16, 16, 16, 255)
  love.graphics.rectangle('fill', xx, yy + hh / 2, ww, hh / 2)

  love.graphics.setLineWidth(3)
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
    wall_draw_quad(1, x1, y1, x2, y2, x3, y3, x4, y4)
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
    wall_draw_quad(2, x1, y1, x2, y2, x3, y3, x4, y4)
  end
  -- draw left far far
  if grid[player.x - 1][player.y - 2] == 1 and grid[player.x][player.y - 1] == 0  and grid[player.x][player.y - 2] == 0 then
    local x1 = xx + ww / 4 + ww / 8
    local y1 = yy + hh / 4 + ww / 8
    local x2 = xx + ww / 4 + ww / 8 + ww / 16
    local y2 = yy + hh / 4 + hh / 8 + ww / 16
    local x3 = x2
    local y3 = y2 + hh / 8
    local x4 = x1
    local y4 = yy + hh - hh / 4 - hh / 8
    wall_draw_quad(3, x1, y1, x2, y2, x3, y3, x4, y4)
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
    wall_draw_quad(1, x1, y1, x2, y2, x3, y3, x4, y4)
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
    wall_draw_quad(2, x1, y1, x2, y2, x3, y3, x4, y4)
  end
  -- draw right far far
  if grid[player.x + 1][player.y - 2] == 1 and grid[player.x][player.y - 1] == 0 and grid[player.x][player.y - 2] == 0 then
    local x1 = xx + ww / 2 + ww / 8
    local y1 = yy + hh / 4 + hh / 8
    local x2 = xx + ww / 2 + ww / 8 - ww / 16
    local y2 = yy + hh / 4 + hh / 8 + hh / 16
    local x3 = x2
    local y3 = y2 + hh / 8
    local x4 = x1
    local y4 = yy + hh - hh / 4 - hh / 8
    wall_draw_quad(3, x1, y1, x2, y2, x3, y3, x4, y4)
  end

  -- draw font left
  if grid[player.x - 1][player.y - 1] == 1 and grid[player.x - 1][player.y] == 0 then
    local x1 = xx
    local y1 = yy + hh / 4
    local w1 = ww / 4
    local h1 = hh / 2
    wall_draw_rect(1, x1, y1, w1, h1)
  end
  -- draw font left far
  if grid[player.x - 1][player.y - 2] == 1 and grid[player.x - 1][player.y - 1] == 0 then
    local x1 = xx + ww / 4
    local y1 = yy + hh / 4 + ww / 8
    local w1 = ww / 8
    if grid[player.x - 1][player.y] == 0 and grid[player.x - 1][player.y - 1] == 0 then
      x1 = xx + ww / 8
      w1 = ww / 4
    end
    local h1 = hh / 4
    wall_draw_rect(2, x1, y1, w1, h1)
  end
  -- draw font left far
  if grid[player.x - 1][player.y - 3] == 1 and grid[player.x - 1][player.y - 2] == 0 then
    local x1 = xx + ww / 4 + ww / 8
    local y1 = yy + hh / 4 + ww / 8 + ww / 16
    local w1 = ww / 16
    if grid[player.x - 1][player.y - 1] == 0 and grid[player.x - 1][player.y - 2] == 0 then
      x1 = xx + ww / 4 + ww / 16
      w1 = ww / 8
    end
    local h1 = hh / 8
    wall_draw_rect(3, x1, y1, w1, h1)
  end

  -- draw front center
  if grid[player.x][player.y - 1] == 1 then
    local x1 = xx + ww / 4
    local y1 = yy + hh / 4
    local w1 = ww / 2
    local h1 = hh / 2
    wall_draw_rect(1, x1, y1, w1, h1)
  end
  -- draw front center far
  if grid[player.x][player.y - 2] == 1 and grid[player.x][player.y - 1] == 0 then
    local x1 = xx + ww / 4 + ww / 8
    local y1 = yy + hh / 4 + ww / 8
    local w1 = ww / 4
    local h1 = hh / 4
    wall_draw_rect(2, x1, y1, w1, h1)
  end
  -- draw front center far far
  if grid[player.x][player.y - 3] == 1 and grid[player.x][player.y - 1] == 0 and grid[player.x][player.y - 2] == 0 then
    local x1 = xx + ww / 4 + ww / 8 + ww / 16
    local y1 = yy + hh / 4 + ww / 8 + ww / 16
    local w1 = ww / 8
    local h1 = hh / 8
    wall_draw_rect(3, x1, y1, w1, h1)
  end

  -- draw font right
  if grid[player.x + 1][player.y -1] == 1 and grid[player.x + 1][player.y] == 0 then
    local x1 = xx + ww - ww / 4
    local y1 = yy + hh / 4
    local w1 = ww / 4
    local h1 = hh / 2
    wall_draw_rect(1, x1, y1, w1, h1)
  end
  -- draw font right far
  if grid[player.x + 1][player.y - 2] == 1 and grid[player.x + 1][player.y - 1] == 0 then
    local x1 = xx + ww - ww / 4 - ww / 8
    local y1 = yy + hh / 4 + ww / 8
    local w1 = ww / 8
    if grid[player.x + 1][player.y] == 0 and grid[player.x + 1][player.y - 1] == 0 then
      if grid[player.x][player.y - 1] == 1 then
        x1 = x1 + ww / 8
      else
        w1 = ww / 4
      end
    end
    local h1 = hh / 4
    wall_draw_rect(2, x1, y1, w1, h1)
  end
  -- draw font right far far
  if grid[player.x + 1][player.y - 3] == 1 and grid[player.x][player.y - 1] == 0 and grid[player.x][player.y - 2] == 0 and grid[player.x + 1][player.y - 2] == 0 then
    local x1 = xx + ww - ww / 4 - ww / 8 - ww / 16
    local y1 = yy + hh / 4 + ww / 8 + ww / 16
    local w1 = ww / 16
    if grid[player.x + 1][player.y - 1] == 0 and grid[player.x + 1][player.y - 2] == 0 then
      w1 = ww / 8
    end
    local h1 = hh / 8
    wall_draw_rect(3, x1, y1, w1, h1)
  end

  -- border
  love.graphics.setLineWidth(1)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.rectangle('line', xx, yy, ww, hh)

end

function wall_draw_quad(dist, x1, y1, x2, y2, x3, y3, x4, y4)
  if dist == 1 then
    love.graphics.setColor(64, 64, 64, 255)
  elseif dist == 2 then
    love.graphics.setColor(48, 48, 48, 255)
  else
    love.graphics.setColor(32, 32, 32, 255)
  end
  love.graphics.polygon('fill', x1, y1, x2, y2, x3, y3, x4, y4)
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.polygon('line', x1, y1, x2, y2, x3, y3, x4, y4)
end

function wall_draw_rect(dist, x, y, w, h)
  if dist == 1 then
    love.graphics.setColor(64, 64, 64, 255)
  elseif dist == 2 then
    love.graphics.setColor(48, 48, 48, 255)
  else
    love.graphics.setColor(32, 32, 32, 255)
  end
  love.graphics.rectangle('fill', x, y, w, h)
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.rectangle('line', x, y, w, h)
end
