--
-- console.lua
-- ===
-- Utilities for debugging in the hammerspoon console. Copied from https://git.io/fpGnm
--

local module = {}

module.init = function()
  -- some global functions for console
  inspect = hs.inspect

  clear = hs.console.clearConsole

  dumpWindows = function()
    hs.fnutils.each(hs.window.allWindows(), function(win)
      print(hs.inspect({
        id               = win:id(),
        title            = win:title(),
        app              = win:application():name(),
        role             = win:role(),
        subrole          = win:subrole(),
      }))
    end)
  end

  dumpScreens = function()
    hs.fnutils.each(hs.screen.allScreens(), function(s)
      print(s:id(), s:position(), s:frame(), s:name())
    end)
  end

  timestamp = function(date)
    date = date or hs.timer.secondsSinceEpoch()
    return os.date("%F %T" .. ((tostring(date):match("(%.%d+)$")) or ""), math.floor(date))
  end

  -- console styling
  local darkMode = true

  local fontStyle = {
    name = "Operator Mono Book",
    size = 14,
  }

  local darkGrayColor = {
    red   = 26 / 255,
    green = 28 / 255,
    blue  = 39 / 255,
    alpha = 1.0,
  }
  local whiteColor = {
    white = 1.0,
    alpha = 1.0,
  }
  local lightGrayColor = {
    white = 1.0,
    alpha = 0.9,
  }
  local purpleColor = {
    red   = 171 / 255,
    green = 126 / 255,
    blue  = 251 / 255,
    alpha = 1.0,
  }
  local grayColor = {
    red   = 24 * 4 / 255,
    green = 24 * 4 / 255,
    blue  = 24 * 4 / 255,
    alpha = 1.0,
  }
  local blackColor = {
    white = 0.0,
    alpha = 1.0,
  }

  hs.console.darkMode(darkMode)
  hs.console.consoleFont(fontStyle)
  hs.console.alpha(0.985)

  if darkMode then
    hs.console.outputBackgroundColor(darkGrayColor)
    hs.console.consoleCommandColor(whiteColor)
    hs.console.consoleResultColor(purpleColor)
    hs.console.consolePrintColor(lightGrayColor)
  else
    hs.console.consoleCommandColor(blackColor)
    hs.console.consoleResultColor(grayColor)
    hs.console.consolePrintColor(grayColor)
  end

  -- no toolbar
  hs.console.toolbar(nil)
end

return module