local beautiful = require("beautiful")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local env = require("env-config")

-- {{{ Menu
-- Create a launcher widget and a main menu
local myawesomemenu = {
  { "hotkeys", function() return false, hotkeys_popup.show_help end},
  { "manual", env.term .. env.term_call[2] .. "man awesome" },
  { "edit config", env.editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end}
}

local myappmenu = {
  { "ncmpcpp", env.term .. env.term_call[1] .. "music_n" .. env.term_call[2] .. "ncmpcpp" },
  { "cava", env.term .. env.term_call[1] .. "music_c" .. env.term_call[2] .. "cava" },
  { "brave", "brave-sec" },
  { "virtualbox", "firejail VirtualBox" },
  { "weechat", env.term .. env.term_call[1] .. "chat" .. env.term_call[2] .. "weechat" },
  { "mutt", env.term .. env.term_call[1] .. "mail" .. env.term_call[2] .. "mutt" },
  { "ranger", env.term .. env.term_call[2] .. "ranger" },
  { "gimp", gimp }
}

local mypentestmenu = {
  { "metasploit", env.term .. env.term_call[2] .. "msf" },
  { "leaked", env.term .. env.term_call[2] .. "leaked.py" },
  { "burpsuite", burpsuite }
}

local mygamemenu = {
  { "baldur's gate 1", "" },
  { "baldur's gate 2", "" },
  { "don't starve", "" }
}

local mymainmenu = awful.menu({ items = 
  {
    { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "open terminal", env.term },
    { "apps", myappmenu },
    { "pentest tools", mypentestmenu },
    { "games", mygamemenu }
  }
})

return mymainmenu
