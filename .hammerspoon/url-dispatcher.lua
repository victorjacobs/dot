hs.loadSpoon("URLDispatcher")
local Zoom = "us.zoom.xos"
local Chrome = "com.google.Chrome"
local Spotify = "com.spotify.client"
spoon.URLDispatcher.url_patterns = {
  {"https?://zoom.us/j/", Zoom},
  {"https?://%w+.zoom.us/j/", Zoom},
  {"https?://open.spotify.com/", Spotify},
}
spoon.URLDispatcher.default_handler = Chrome
spoon.URLDispatcher:start()
