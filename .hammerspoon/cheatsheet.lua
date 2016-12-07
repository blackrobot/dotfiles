------------------------------------------------------------------------
--/ Cheatsheet Copycat /--
------------------------------------------------------------------------

module = {}

local commandEnum = {
  [0] = '⌘',
  [1] = '⇧ ⌘',
  [2] = '⌥ ⌘',
  [3] = '⌥ ⇧ ⌘',
  [4] = '⌃ ⌘',
  [5] = '⇧ ⌃ ⌘',
  [6] = '⌃ ⌥ ⌘',
  [7] = '',
  [8] = '⌦',
  [9] = '',
  [10] = '⌥',
  [11] = '⌥ ⇧',
  [12] = '⌃',
  [13] = '⌃ ⇧',
  [14] = '⌃ ⌥',
}

function getAllMenuItemsTable(t)
  local menu = {}
  for pos, val in pairs(t) do
    if(type(val)=="table") then
      if(val['AXRole'] =="AXMenuBarItem" and type(val['AXChildren']) == "table") then
        menu[pos] = {}
        menu[pos]['AXTitle'] = val['AXTitle']
        menu[pos][1] = getAllMenuItems(val['AXChildren'][1])
      elseif(val['AXRole'] =="AXMenuItem" and not val['AXChildren']) then
        if( val['AXMenuItemCmdModifiers'] ~='0' and val['AXMenuItemCmdChar'] ~='') then
          menu[pos] = {}
          menu[pos]['AXTitle'] = val['AXTitle']
          menu[pos]['AXMenuItemCmdChar'] = val['AXMenuItemCmdChar']
          menu[pos]['AXMenuItemCmdModifiers'] = val['AXMenuItemCmdModifiers']
        end
      elseif(val['AXRole'] =="AXMenuItem" and type(val['AXChildren']) == "table") then
        menu[pos] = {}
        menu[pos][1] = getAllMenuItems(val['AXChildren'][1])
      end
    end
  end
  return menu
end


function getAllMenuItems(t)
  local menu = ""

  for pos, val in pairs(t) do
    if (type(val) == "table") then
      -- do not include help menu for now until I find best way to remove menubar items with no shortcuts in them
      if (val['AXRole'] =="AXMenuBarItem" and type(val['AXChildren']) == "table") and val['AXTitle'] ~="Help" then
        menu = menu.."<ul class='col col"..pos.."'>"
        --print("---------------| "..val['AXTitle'].." |---------------")
        menu = menu.."<li class='title'><strong>"..val['AXTitle'].."</strong></li>"
        menu = menu.. getAllMenuItems(val['AXChildren'][1])
        menu = menu.."</ul>"
      elseif(val['AXRole'] =="AXMenuItem" and not val['AXChildren']) then
        if( val['AXMenuItemCmdModifiers'] ~='0' and val['AXMenuItemCmdChar'] ~='') then
          --print(val['AXMenuItemCmdModifiers'].." | "..val['AXTitle'].." | CmdChar: "..val['AXMenuItemCmdChar'])
          menu = menu.."<li><div class='cmdModifiers'>"..commandEnum[val['AXMenuItemCmdModifiers']].." "..val['AXMenuItemCmdChar'].."</div><div class='cmdtext'>".." "..val['AXTitle'].."</div></li>"
        end
      elseif(val['AXRole'] =="AXMenuItem" and type(val['AXChildren']) == "table") then
        menu = menu..getAllMenuItems(val['AXChildren'][1])
      end

    end
  end
  return menu
end

-- Read javascript file
local _css_content = nil
function css_content()
  if (_css_content == nil) then
    local f = io.open(os.getenv("HOME") .. "/.hammerspoon/cheatsheet/main.css", "r")
    _css_content = f:read("*all")
    f:close()
  end

  return _css_content
end

function generateHtml(app)
  local menu_items = getAllMenuItems(app:getMenuItems())

  return [[
  <!doctype html>
  <html>
  <head>
    <style type="text/css">]]..css_content()..[[</style>
  </head>
  <body>
    <header>
      <div class="title">
        <strong>]]..app:title()..[[</strong>
      </div>
    </header>
    <div class="content maincontent">]]..menu_items..[[</div>
  </body>
  </html>
  ]]
end


viewer = nil
module.windowStyle = {
  "utility",
  -- "resizable",
  "nonactivating",
  "titled",
  -- "HUD",
  "closable",
}

function buildView()
  local app = hs.application.frontmostApplication()
  local windowDims = hs.screen.mainScreen():fullFrame()

  windowDims.x = (windowDims.w / 2) - (1080 / 2)
  windowDims.y = windowDims.h * 0.1
  windowDims.w = 1080
  windowDims.h = windowDims.h * 0.8

  local view_new = hs.webview.new(windowDims, { developerExtrasEnabled = true })
    :html(generateHtml(app))
    :allowGestures(true)
    :windowTitle("Shortcuts")
    :windowStyle(module.windowStyle)
    :closeOnEscape(true)
    :level(hs.drawing.windowLevels.modalPanel)
    :transparent(true)

  return view_new
end

function destroyView()
  viewer:delete(true, 0.3)
  viewer = nil
end

module.toggle = function()
  if viewer == nil then
    viewer = buildView()
    viewer:show(0.3)
          :hswindow().setShadows(true)
    viewer:hswindow():focus()
  else
    destroyView()
  end
end

-- hs.hotkey.bind(mash, "/", cheetsheet.toggle)

return module
