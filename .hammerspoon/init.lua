require('console').init()
require('spoons').init(true)
require('organize_downloads').init()

-- General settings
mash = { "ctrl", "alt" }
shift_mash = { "ctrl", "alt", "shift" }

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

-- General settings
hs.application.enableSpotlightForNameSearches(true)

-- Window Hints
-- https://www.hammerspoon.org/docs/hs.hints.html
-- hs.hints.fontName = ""         -- Default uses system font
hs.hints.fontSize = 22.0          -- Set to 0.0 to use default size
-- hs.hints.hintChars = ""        -- Ignored when using "vimperator" style
hs.hints.iconAlpha = 0.80         -- Default is 0.95
hs.hints.showTitleThresh = 8      -- Default is 4
hs.hints.style = "vimperator"
hs.hints.titleMaxSize = 8

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

-- Space mover
space_mover = require("space_mover")
hs.hotkey.bind(shift_mash, "right", function()
  space_mover.moveNext()
end)
hs.hotkey.bind(shift_mash, "left", function()
  space_mover.movePrevious()
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


-- Frequently used app hotkey switching
freq_app = {}

freq_app.bundles = {
  browsers = {
    -- Google Chrome
    "Google Chrome", "Chrome",
    -- Mozilla Firefox
    "Mozilla Firefox", "Firefox", "Nightly",
    -- Other
    "Safari",
  },
  terminals = { "iTerm2", "Alacritty", "Terminal" },
  editors = {
    "Code - Insiders",
    "Code",
    "VimR",
    "Vim",
  },
}

function freq_app.activate(app_names)
  local fallback_app = nil

  for i, name in ipairs(app_names) do
    local app = hs.application.find(name)

    if app then
      local windows = app:allWindows()

      if windows then
        return windows[1]:focus()
      end

      fallback_app = app
    end
  end

  if fallback_app then
    return fallback_app:activate()
  end

  return nil
end

function freq_app.factory(app_names)
  return function() freq_app.activate(app_names) end
end

hs.hotkey.bind(mash, "h", freq_app.factory(freq_app.bundles.browsers))
hs.hotkey.bind(mash, "j", freq_app.factory(freq_app.bundles.terminals))
hs.hotkey.bind(mash, "l", freq_app.factory({"Slack"}))
hs.hotkey.bind(mash, "o", freq_app.factory({"Finder"}))
hs.hotkey.bind(mash, "p", freq_app.factory({"Preview"}))
hs.hotkey.bind(mash, "k", freq_app.factory(freq_app.bundles.editors))


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

