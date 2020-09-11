require "window-management"
require "key-bindings"
require "url-dispatcher"

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- TODO move some of these to their own files
usbWatcher = hs.usb.watcher.new(function(e)
  if e["productName"] ~= "DZ60" then
    return
  end

  print(e["eventType"])
end)

usbWatcher:start()

-- ddctl brightness
local brightness = 100
hs.hotkey.bind({'cmd', 'shift', 'alt'}, 'down', function()
  brightness = math.max(0, brightness - 10)

  hs.execute('/Users/vjacobs/dev/ddcctl/ddcctl -d 1 -b ' .. brightness)
end)
hs.hotkey.bind({'cmd', 'shift', 'alt'}, 'up', function()
  brightness = math.min(100, brightness + 10)

  hs.execute('/Users/vjacobs/dev/ddcctl/ddcctl -d 1 -b ' .. brightness)
end)
