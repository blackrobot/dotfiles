-- General settings
mash = {"ctrl", "alt"}

hs.window.animationDuration = 0.01

-- Hints
hs.hints.fontSize = 26.0
hs.hints.showTitleThresh = 0
hs.hints.hintChars = {"A", "S", "D", "F", "Q", "W", "E", "R",
                      "J", "K", "L", ";", "U", "I", "O", "P"}

-- Grid
hs.grid.GRIDHEIGHT = 6
hs.grid.GRIDWIDTH = 6
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0

-- Funcz
hs.hotkey.bind(mash, "end", function()
  hs.reload()
  hs.notify.show("Hammerspoon", "", "Reloaded configuration", "")
end)

hs.hotkey.bind("alt", "tab", hs.hints.windowHints)

hs.hotkey.bind(mash, "return", hs.grid.show)

-- Cheatsheet
import = require('import')
import.clear_cache()

csheet = import('cheatsheet')
hs.hotkey.bind(mash, "/", function()
  csheet.toggle()
end)

-- Screensaver hotkey
hs.hotkey.bind(mash, "forwarddelete", function()
  hs.timer.doAfter(0.35, function()
    hs.caffeinate.startScreensaver()
  end)
end)

hs.hotkey.bind(mash, "\\", function()
  local win = hs.window.focusedWindow()
  hs.grid.maximizeWindow(win)
end)

local function snapAndSize(win, dir)
  local pos = hs.grid.snap(win).get(win)

  local max_height = 4
  local min_height = 2

  local max_width = 4
  local min_width = 2

  pos.y = 0
  pos.h = hs.grid.GRIDHEIGHT
  pos.w = pos.w - 1

  if pos.w < min_width then
    pos.w = max_width
  elseif pos.w > max_width then
    pos.w = min_width
  end

  if dir == "right" then
    pos.x = hs.grid.GRIDWIDTH - pos.w
  else
    pos.x = 0
  end

  hs.grid.set(win, pos)
end

hs.hotkey.bind(mash, "right", function()
  local win = hs.window.focusedWindow()
  -- local half_width = hs.grid.GRIDWIDTH / 2
  -- hs.grid.snap(win).set(win, {half_width, 0, half_width, hs.grid.GRIDHEIGHT})
  snapAndSize(win, "right")
end)

hs.hotkey.bind(mash, "left", function()
  local win = hs.window.focusedWindow()
  -- local half_width = hs.grid.GRIDWIDTH / 2
  -- hs.grid.snap(win).set(win, {0, 0, half_width, hs.grid.GRIDHEIGHT})
  snapAndSize(win, "left")
end)

hs.hotkey.bind(mash, "up", function()
  local win = hs.window.focusedWindow()
  local cell = hs.grid.snap(win).get(win)
  cell.y = 0
  cell.h = hs.grid.GRIDHEIGHT / 2
  hs.grid.set(win, cell)
end)

hs.hotkey.bind(mash, "down", function()
  local win = hs.window.focusedWindow()
  local cell = hs.grid.snap(win).get(win)
  cell.h = hs.grid.GRIDHEIGHT / 2
  cell.y = cell.h
  hs.grid.set(win, cell)
end)

local function activateApp(...)
  for i, name in ipairs({...}) do
    local app = hs.application.get(name)
    if app then
      return app:activate()
    end
  end
  return nil
end

hs.hotkey.bind(mash, "h", function() activateApp("Google Chrome") end)
hs.hotkey.bind(mash, "j", function() activateApp("iTerm2") end)
hs.hotkey.bind(mash, "k", function() activateApp("MacVim", "Neovim") end)
hs.hotkey.bind(mash, "l", function() activateApp("Slack") end)
hs.hotkey.bind(mash, "o", function() activateApp("Finder") end)
hs.hotkey.bind(mash, "p", function() activateApp("Preview") end)


-- print screen = f13


function moveWindowOneSpace(direction)
  local mouseOrigin = hs.mouse.getAbsolutePosition()
  local win = hs.window.focusedWindow()
  local clickPoint = win:zoomButtonRect()

  clickPoint.x = clickPoint.x + clickPoint.w + 5
  clickPoint.y = clickPoint.y + (clickPoint.h / 2)

  local mouseClickEvent = hs.eventtap.event.newMouseEvent(
    hs.eventtap.event.types.leftMouseDown, clickPoint)
  mouseClickEvent:post()
  hs.timer.usleep(150000)

  local nextSpaceDownEvent = hs.eventtap.event.newKeyEvent(
    {"ctrl"}, direction, true)
  nextSpaceDownEvent:post()
  hs.timer.usleep(150000)

  local nextSpaceUpEvent = hs.eventtap.event.newKeyEvent(
    {"ctrl"}, direction, false)
  nextSpaceUpEvent:post()
  hs.timer.usleep(150000)

  local mouseReleaseEvent = hs.eventtap.event.newMouseEvent(
    hs.eventtap.event.types.leftMouseUp, clickPoint)
  mouseReleaseEvent:post()
  hs.timer.usleep(150000)

  hs.mouse.setAbsolutePosition(mouseOrigin)
end

mash_too = {"shift", "ctrl", "alt"}
hs.hotkey.bind(mash_too, "right", function() moveWindowOneSpace("right") end)
hs.hotkey.bind(mash_too, "left", function() moveWindowOneSpace("left") end)
