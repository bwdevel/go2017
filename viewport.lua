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
