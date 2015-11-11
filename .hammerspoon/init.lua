-- General settings
mash = {"ctrl", "alt"}

hs.window.animationDuration = 0.05

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
end)

hs.hotkey.bind("alt", "tab", hs.hints.windowHints)

hs.hotkey.bind(mash, "return", hs.grid.show)

hs.hotkey.bind(mash, "\\", function()
  local win = hs.window.focusedWindow()
  hs.grid.maximizeWindow(win)
end)

hs.hotkey.bind(mash, "right", function()
  local win = hs.window.focusedWindow()
  local half_width = hs.grid.GRIDWIDTH / 2
  hs.grid.snap(win).set(win, {half_width, 0, half_width, hs.grid.GRIDHEIGHT})
end)

hs.hotkey.bind(mash, "left", function()
  local win = hs.window.focusedWindow()
  local half_width = hs.grid.GRIDWIDTH / 2
  hs.grid.snap(win).set(win, {0, 0, half_width, hs.grid.GRIDHEIGHT})
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

local chrome = hs.application.get("Google Chrome")
local iterm = hs.application.get("iTerm2")
local vim = hs.application.get("MacVim") or hs.application.get("Neovim")
local hipchat = hs.application.get("HipChat")
local finder = hs.application.get("Finder")
local preview = hs.application.get("Preview")

local function activateApp(app)
  if (app) then
    return app:activate()
  else
    return app
  end
end

hs.hotkey.bind(mash, "h", function() activateApp(chrome) end)
hs.hotkey.bind(mash, "j", function() activateApp(iterm) end)
hs.hotkey.bind(mash, "k", function() activateApp(vim) end)
hs.hotkey.bind(mash, "l", function() activateApp(hipchat) end)
hs.hotkey.bind(mash, "o", function() activateApp(finder) end)
hs.hotkey.bind(mash, "p", function() activateApp(preview) end)
