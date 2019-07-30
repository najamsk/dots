local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local widget = require("util.widgets")

-- beautiful vars
local net_icon = beautiful.widget_network_icon
local fg = beautiful.widget_network_fg
local fg_error = beautiful.widget_network_fg_error
local bg = beautiful.widget_network_bg
local l = beautiful.widget_network_layout or 'horizontal'

-- widget creation
local icon = widget.base_icon(bg, net_icon)
local text = widget.base_text()
local icon_margin = widget.icon(bg, icon)
local text_margin = widget.text(bg, text)
network_widget = widget.box(l, icon_margin, text_margin)

awful.widget.watch(
  os.getenv("HOME").."/.config/awesome/widgets/network.sh net", 60,
  function(widget, stdout, stderr, exitreason, exitcode)
    if (stdout == "1") then
      icon:set_markup_silently('<span foreground="'..fg_error..'">'..net_icon..'</span>')
      text:set_markup_silently('<span foreground="'..fg..'">no network found</span>')
    else
      text:set_markup_silently('<span foreground="'..fg..'">'..stdout..'</span>')
    end
  end
)
