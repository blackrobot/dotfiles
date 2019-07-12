
local module = {}
local hyper = { "ctrl", "alt" }

module.init = function(load, update)
  installer = hs.loadSpoon("SpoonInstall")

  if ( load ~= false ) then
    module.loadSpoons()
  end

  if ( update == true ) then
    -- todo
  end
end

module.loadSpoons = function()
  spoon.SpoonInstall.use_syncinstall = true

  spoon.SpoonInstall:andUse("ReloadConfiguration", {
    start   = true,
    hotkeys = { reloadConfiguration = { hyper, "end" } },
  })

  -- spoon.SpoonInstall:andUse("KSheet", {
  --   hotkeys = { toggle = { hyper, "?" } },
  -- })

  -- Can't get this to work :(
  -- spoon.SpoonInstall:andUse("MoveSpaces", {
  --   hotkeys = {
  --     space_right = {{ "ctrl", "alt", "shift" }, "right" },
  --     space_left  = {{ "ctrl", "alt", "shift" }, "left" },
  --   }
  -- })
end

return module
