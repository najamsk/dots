local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")
local helpers = require("helpers")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local ncmpcpp_bar = require("widgets.ncmpcpp")
local pad = wibox.widget.textbox(" ")

local titlebars = {}

-- Disable popup tooltip on titlebar button hover
awful.titlebar.enable_tooltip = false

-- buttons for the titlebar
titlebars.buttons = gears.table.join(
  awful.button({ }, 1, function()
    local c = mouse.object_under_pointer()
    client.focus = c
    c:raise()
    awful.mouse.client.move(c)
  end),
  awful.button({ }, 3, function()
    local c = mouse.object_under_pointer()
    client.focus = c
    c:raise()
    awful.mouse.client.resize(c)
  end)
)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)

  local buttons = titlebars.buttons

  if beautiful.titlebars_imitate_borders then
    helpers.create_titlebar(c, buttons, "top", beautiful.titlebar_size)
    helpers.create_titlebar(c, buttons, "bottom", beautiful.titlebar_size)
    helpers.create_titlebar(c, buttons, "left", beautiful.titlebar_size)
    helpers.create_titlebar(c, buttons, "right", beautiful.titlebar_size)
  else 
    if c.class == "music_n" then
      awful.titlebar(c, {
        font = beautiful.titlebar_font, position = "bottom", size= dpi(50)
      }) : setup {
        nil,
        {
          nil,
          { -- music player
          ncmpcpp_prev_icon,
          pad,
          ncmpcpp_toggle_icon,
          pad,
          ncmpcpp_next_icon,
          layout  = wibox.layout.fixed.horizontal
          },
          nil,
          expand = "none",
          layout = wibox.layout.align.vertical
        },
        nil,
        expand = "none",
        layout = wibox.layout.align.horizontal
      }
    -- then
    end
      awful.titlebar(c) : setup {
        { --left
          --awful.titlebar.widget.iconwidget(c),
          buttons = buttons,
          layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
          { -- Title
            align  = "center",
            widget = awful.titlebar.widget.titlewidget(c)
          },
          buttons = buttons,
          layout  = wibox.layout.flex.horizontal
        },
        { -- Right
          --awful.titlebar.widget.floatingbutton (c),
          --awful.titlebar.widget.maximizedbutton(c),
          --awful.titlebar.widget.stickybutton   (c),
          --awful.titlebar.widget.ontopbutton    (c),
          --awful.titlebar.widget.closebutton    (c),
          layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
      }
    -- end
  end
end)

return titlebars
