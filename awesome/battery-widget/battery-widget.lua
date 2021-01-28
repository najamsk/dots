-------------------------------------------------
-- Battery Widget for Awesome Window Manager
-- Shows the battery status using the ACPI tool
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/battery-widget

-- @author Pavel Makhov
-- @copyright 2017 Pavel Makhov
-------------------------------------------------
--Modified by bone3ye to use local icons instead of those from an icon theme. Graphics for local icons borrowed from Paper Icon Theme
--
-------------------------------------------------

local awful = require("awful")
local naughty = require("naughty")
local watch = require("awful.widget.watch")
local wibox = require("wibox")

-- acpi sample outputs
-- Battery 0: Discharging, 75%, 01:51:38 remaining
-- Battery 0: Charging, 53%, 00:57:43 until charged

local HOME = os.getenv("HOME")
local PATH_TO_ICONS = HOME .. "/.config/awesome/battery-widget/svg/"

local battery_widget = wibox.widget {
    {
        id = "icon",
        widget = wibox.widget.imagebox,
        resize = false
    },
    --margin of 3 on the end put the widget too low (for 24px wibar)
    -- layout = wibox.container.margin(_, 0, 0, 3)
    layout = wibox.container.margin(_, 0, 0, 4)
}


--local battery_widget = require("awesome-wm-widgets.battery-widget.battery")

-- Popup with battery info
-- One way of creating a pop-up notification - naughty.notify
local notification

local function show_battery_status()
    awful.spawn.easy_async([[bash -c 'acpi']],
        function(stdout, _, _, _)
            notification = naughty.notify{
                text =  stdout,
                title = "Battery status",
                timeout = 5, hover_timeout = 0.5,
                width = 200,
            }
        end
    )
end

-- Alternative to naughty.notify - tooltip. You can compare both and choose the preferred one
--battery_popup = awful.tooltip({objects = {battery_widget}})

-- To use colors from beautiful theme put
-- following lines in rc.lua before require("battery"):
-- beautiful.tooltip_fg = beautiful.fg_normal
-- beautiful.tooltip_bg = beautiful.bg_normal

local function show_battery_warning()
    naughty.notify{
        --icon = HOME .. "/.config/awesome/nichosi.png",
        --icon_size=100,
        text = "Huston, we have a problem",
        title = "Battery is dying",
        timeout = 5, hover_timeout = 0.5,
        position = "bottom_right",
        bg = "#F06060",
        fg = "#EEE9EF",
        width = 300,
    }
end

watch("acpi", 10,
    function(widget, stdout, stderr, exitreason, exitcode)
        local batteryType
        local _, status, charge_str, time = string.match(stdout, '(.+): (%a+), (%d?%d?%d)%%,? ?.*')
        local charge = tonumber(charge_str)

        -- naughty.notify({title="hello world!", text="hello world from najam"})

        if (charge >= 0 and charge < 15) then
            batteryType = "battery-low%s"
            if status ~= 'Charging' then
                show_battery_warning()
            end
        --elseif (charge >= 15 and charge < 40) then batteryType = "battery-caution%s-symbolic"
        --elseif (charge >= 40 and charge < 60) then batteryType = "battery-low%s-symbolic"
        --elseif (charge >= 60 and charge < 80) then batteryType = "battery-good%s-symbolic"
        --elseif (charge >= 80 and charge <= 100) then batteryType = "battery-full%s-symbolic"
        elseif (charge >= 15 and charge < 40) then batteryType = "battery-low%s"
        elseif (charge >= 40 and charge < 60) then batteryType = "battery-40%s"
        elseif (charge >= 60 and charge < 80) then batteryType = "battery-60%s"
        elseif (charge >= 80 and charge <= 100) then batteryType = "battery-100%s"
        end
        if status == 'Charging' then
            batteryType = string.format(batteryType, '-charging')
        else
            batteryType = string.format(batteryType, '')
        end
        widget.icon:set_image(PATH_TO_ICONS .. batteryType .. ".svg")

        --naughty.notify{
        --   text = PATH_TO_ICONS .. batteryType .. ".png"
        --}

        -- Update popup text
        -- battery_popup.text = string.gsub(stdout, "\n$", "")
    end,
    battery_widget)

battery_widget:connect_signal("mouse::enter", function() show_battery_status() end)
battery_widget:connect_signal("mouse::leave", function() naughty.destroy(notification) end)

return battery_widget
