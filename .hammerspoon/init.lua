-- General settings
mash = {"ctrl", "alt"}

hs.window.animationDuration = 0.01

local function toRGB(color_table)
  return hs.drawing.color.asRGB(color_table)
end

-- Grid
hs.grid.GRIDHEIGHT = 6
hs.grid.GRIDWIDTH = 8
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
-- Grid.ui
hs.grid.ui.textColor = { 1, 1, 1, 0.95 }
hs.grid.ui.cellColor = { 0, 0, 0, 0.15 }
hs.grid.ui.cellStrokeColor = { 0, 0, 0, 0.35 }
hs.grid.ui.selectedColor = toRGB({ hex = "#EC407A", alpha = 0.5 }) -- Material Pink 400
hs.grid.ui.highlightColor = toRGB({ hex = "#29B6F6", alpha = 0.5 }) -- Material Light Blue 400
hs.grid.ui.highlightStrokeColor = toRGB({ hex = "#29B6F6", alpha = 0.6 }) -- Material Light Blue 400
hs.grid.ui.cyclingHighlightColor = toRGB({ hex = "#FF7043", alpha = 0.5 }) -- Material Deep Orange 400
hs.grid.ui.cyclingHighlightStrokeColor = toRGB({ hex = "#FF7043", alpha = 0.6 }) -- Material Deep Orange 400
hs.grid.ui.fontName = 'Ubuntu Light'
hs.grid.ui.textSize = 100
hs.grid.ui.cellStrokeWidth = 5
hs.grid.ui.highlightStrokeWidth = 10

-- Funcz
function shouldReload(files)
  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      return true
    end
  end

  return false
end

function reloadConfig()
  hs.reload()
  hs.notify.show("Hammerspoon", "", "Reloaded configuration", "")
end

hs.hotkey.bind(mash, "end", reloadConfig)
confWatcher = hs.pathwatcher.new(
  os.getenv("HOME") .. "/.hammerspoon",
  function(files)
    if shouldReload(files) then
      reloadConfig()
    end
  end
):start()

-- Window Hints
hs.hints.fontSize = 26.0
hs.hints.showTitleThresh = 6
hs.hints.style = "vimperator"
hs.hints.titleMaxSize = 12

-- * Hint all
hs.hotkey.bind("alt", "tab", hs.hints.windowHints)
-- * Hint current app
hs.hotkey.bind("alt", "`", function()
  hs.hints.windowHints(
    hs.window.focusedWindow():application():allWindows()
  )
end)

-- Grid
hs.hotkey.bind(mash, "return", hs.grid.show)

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

grid_limit = {
  min = {
    width = 2,
    height = 1,
  },
  max = {
    width = hs.grid.GRIDWIDTH - 2,
    height = hs.grid.GRIDHEIGHT - 1,
  },
}

local function snapAndSize(win, dir)
  local pos = hs.grid.snap(win).get(win)

  pos.y = 0
  pos.h = hs.grid.GRIDHEIGHT
  pos.w = pos.w - 1

  if pos.w < grid_limit.min.width then
    pos.w = grid_limit.max.width
  elseif pos.w > grid_limit.max.width then
    pos.w = grid_limit.min.width
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
  snapAndSize(win, "right")
end)

hs.hotkey.bind(mash, "left", function()
  local win = hs.window.focusedWindow()
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


hs.hotkey.bind(mash, "h", function()
  activateApp("Google Chrome", "Nightly", "FirefoxDeveloperEdition")
end)
hs.hotkey.bind(mash, "j", function() activateApp("iTerm2") end)
hs.hotkey.bind(mash, "l", function() activateApp("Slack") end)
hs.hotkey.bind(mash, "o", function() activateApp("Finder") end)
hs.hotkey.bind(mash, "p", function() activateApp("Preview") end)
hs.hotkey.bind(mash, "k", function()
  activateApp("Code - Insiders", "Code", "VimR")
end)


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

function changeVolume(ticks)
  return function()
    local currentVolume = hs.audiodevice.defaultOutputDevice():volume()
    local newVolume = math.min(100, math.max(0, math.floor(currentVolume + ticks)))

    if newVolume > 0 then
      hs.audiodevice.defaultOutputDevice():setMuted(false)
    end

    hs.alert.closeAll(0.0)
    hs.alert.show("Volume " .. newVolume .. "%", {}, 0.5)
    hs.audiodevice.defaultOutputDevice():setVolume(newVolume)
  end
end

hs.hotkey.bind(mash, "f11", changeVolume(-3))
hs.hotkey.bind(mash, "f12", changeVolume(3))