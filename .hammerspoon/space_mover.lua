-- Move window to space
--
-- Notes:
-- https://github.com/Hammerspoon/hammerspoon/issues/1946
-- `hs.eventtap.keyStroke({ "fn", "crtl" }, "right", 0)
--

local obj = {}
local spaces = require("hs._asm.undocumented.spaces")

obj.name = "SpaceMover"
obj.version = "1"

obj.enable_animation = false

obj.logger = hs.logger.new("space_mover")
-- obj.logger.setLogLevel("debug")


obj.step = function(info, count)
  -- Return the value from the items array that is `count` from the current
  -- `position` index.
  -- note: `#items` returns the length of the `items` table (array)
  local index = hs.fnutils.indexOf(info.available, info.current) + count
  if index > #info.available then
    index = 1
  elseif index < 1 then
    index = #info.available
  end
  return info.available[index]
end


obj.info = function(window)
  -- If `window` is `nil`, use the currently focused window
  if window == nil then
    window = hs.window.focusedWindow()
  end

  local data = { window = window }

  data.uuid = window:screen():spacesUUID()
  data.available = spaces.layout()[data.uuid]
  data.current = window:spaces()[1]

  return data
end


obj.move = function(window, id)
  spaces.moveWindowToSpace(window:id(), id)
  spaces.changeToSpace(id)
end


obj.moveNext = function()
  local window = hs.window.focusedWindow()
  local info = obj.info(window)
  local space = obj.step(info, 1)

  if obj.enable_animation then
    obj.animateTo(info, space)
  else
    obj.move(window, space)
  end
end


obj.movePrevious = function()
  local window = hs.window.focusedWindow()
  local info = obj.info(window)
  local space = obj.step(info, -1)

  if obj.enable_animation then
    obj.animateTo(info, space)
  else
    obj.move(window, space)
  end
end


obj.animateTo = function(info, space)
  local index = hs.fnutils.indexOf(info.available, space)
  hs.eventtap.keyStroke({ "ctrl" }, tostring(index), 1)
  spaces.moveWindowToSpace(info.window:id(), space)
end


return obj