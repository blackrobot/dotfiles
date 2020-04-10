----------------------------------------------------------------------------------------
-- Organize Downloads
-- ==================
-- Watch the ~/Downloads folder and move new files to folders based on extension.
--
-- Reference:
--   * https://www.hammerspoon.org/docs/hs.pathwatcher.html
--
----------------------------------------------------------------------------------------

local fnutils      = require "hs.fnutils"
local fs           = require "hs.fs"
local inspect      = require "hs.inspect"
local notify       = require "hs.notify"
local pathwatcher  = require "hs.pathwatcher"


local module = {}


module.init = function()
  local SHOW_NOTIFICATION = false

  local homePath = os.getenv("HOME")
  local downloadPath = homePath .. "/Downloads/"
  local torrentPath = downloadPath .. "torrents/"


  function splitPath(path)
    -- Given a path string, return the parts as a 3-string array.
    -- https://www.fhug.org.uk/wiki/wiki/doku.php?id=plugins:code_snippets:split_filename_in_to_path_filename_and_extension
    --
    --   >>> path, file, extension = splitPath("/path/to/files/example.txt")
    --   >>> print(path, file, extension)
    --   "/path/to/files/", "example.txt", "txt"
    --

    if fs.attributes(path, "mode") == "directory" then
      local dirpath = path:gsub("[\\/]$", "")
      return dirpath .. "\\", "", ""
    end

    path = path .. "."
    return path:match("^(.-)([^\\/]-%.([^\\/%.]-))%.?$")
  end


  function handleTorrent(context)
    ---
    -- TODO: Handle moving torrent files to watch directory based on where it was
    -- downloaded from. For example:
    --
    --   local origin = hs.fs.xattr.get(path, "com.apple.metadata:kMDItemWhereFroms"))
    --   if origin then
    --     if string.match(origin, "myanonamouse.net") then
    --       os.rename(path, homePath .. "/Torrents/Watch/myanonymouse.net/")
    --     end
    --   end
    --
    -- Just make sure that the ~/Torrents/ path exists and the drive is mounted...
    ---

    if context.extension == "torrent" and context.inRoot then
      local newPath = torrentPath .. context.filename

      if SHOW_NOTIFICATION then
        notify.new({
          title = "Hammerspoon",
          informativeText = "Moved torrent file to " .. newPath,
        }):send()
      end

      return os.rename(context.path, newPath)
    end

    return false
  end


  local handlers = {
    handleTorrent,
  }


  function routeFile(paths, flagTables)
    for _, path in pairs(paths) do
      local directory, filename, extension = splitPath(path)
      local context = {
        path      = path,
        directory = directory,
        filename  = filename,
        extension = extension,

        created   = flagTables[1].itemCreated,
        removed   = flagTables[1].itemRemoved,

        isFile    = flagTables[1].isFile,
        isDir     = flagTables[1].isDir,
        isSymlink = flagTables[1].isSymlink,
        inRoot    = (directory == downloadPath),
      }

      fnutils.some(handlers, function(handler)
        return handler(context)
      end)
    end
  end

  -- Create downloads subdirs
  fs.mkdir(torrentPath)

  downloadsWatcher = pathwatcher.new(downloadPath, routeFile)
  downloadsWatcher:start()
end

return module
