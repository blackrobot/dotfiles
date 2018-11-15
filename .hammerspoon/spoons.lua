
local module = {}

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
  spoon.SpoonInstall:andUse("ReloadConfiguration", {
    start   = true,
    hotkeys = { reloadConfiguration = {{ "ctrl", "alt" }, "end" } },
  })
end

return module