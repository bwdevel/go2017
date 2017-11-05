require './viewport'

function love.load()
  love.graphics.setBackgroundColor(32, 0, 0)
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

  viewport  = {}
  viewport.w = 512
  viewport.h = 512
  viewport.x = 100
  viewport.y = love.graphics.getHeight() / 2 - viewport.h / 2
  viewport.ox = 0
  viewport.oy = 0

  viewport.stencil = function()
    local w = viewport.w
    local h = viewport.h
    local x = viewport.x + viewport.ox
    local y = viewport.y + viewport.oy
    love.graphics.rectangle('fill', x, y, w, h)
  end

  shaker = shake_init(0, 0)
end

function love.update(dt)
  shake_update(shaker, dt)
  --viewport_update(dt)
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
  if key == 'r' then
    grid = rotate_grid(grid)
  end
  if key == 'printscreen' then
    local screenshot = love.graphics.newScreenshot()
    local filename = tostring(os.time()) .. '.png'
    print("Creating screenshot: " .. filename)
    screenshot:encode('png', filename)
  end
  if key == 'v' then
    --[[viewport.ox = math.random(5.0, 10.0)
    if math.random(0, 1) == 1 then viewport.ox = -(viewport.ox) end
    viewport.oy = math.random(5.0, 10.0)
    if math.random(0, 1) == 1 then viewport.oy = -(viewport.oy) end
    ]]
    shaker = shake_init(5, 0.5)
  end
end

function debug_draw()
  local debug_text = {
    'FPS: ' .. tostring(love.timer.getFPS()),
    'Player x/y: ' .. tostring(player.x) .. '/' .. tostring(player.y),
    'Current Sqr Val: ' .. tostring(grid[player.x][player.y]),
    'Player Rot: ' .. tostring(player.rot) .. '(' .. tostring(rotations[player.rot]) .. ')',
    'Viewport offset (x/y): ' .. tostring(viewport.ox) .. '/' .. tostring(viewport.oy)
  }
  local x = 10
  local y = 10
  local w = 400
  local h = 16 * #debug_text + 4
  love.graphics.setColor(0, 0, 0, 128)
  love.graphics.rectangle('fill', x, y, w, h)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.rectangle('line', x, y, w, h)

  for i = 1, #debug_text, 1 do
    love.graphics.print(tostring(debug_text[i]), x + 2, y + (i - 1) * 16 + 2)
  end
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

function rotate_grid(tbl)
  -- https://gist.github.com/LaserDogRob/5604878
  local out = {}
  for i = 1, #tbl[1], 1 do
    out[i] = {}
    local cellNum = 0
    for j = #tbl, 1, -1 do
      cellNum = cellNum + 1
      out[i][cellNum] = tbl[j][i]
    end
  end
  return out
end

function print_grid(grid)
  for x = 1, #grid, 1 do
    out = ''
    for y = 1, #grid[x], 1 do
      out = out .. tostring(grid[x][y]) .. ','
    end
    print(out)
  end
end
