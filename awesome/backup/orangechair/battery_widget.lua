----------------------------------
--   battery_widget             --
--   by bone3ye                 --
--   based on pavelmakhov.com   --
----------------------------------

local awful = require("awful")
local naughty = require("naughty")
local wibox = require("wibox")

local HOME = os.getenv("HOME")
local PATH_TO_ICONS = HOME .. "/.config/awesome/battery-widget/"

--create the wibox widget
local battery_widget = wibox.widget {
    {
        id = "icon",
        widget = wibox.widget.imagebox,
        resize = false
    },
    layout = wibox.container.margin(_, 0, 0, 3)
}

--function to read /sys/class files to determine the name of the battery
function readBatFile(adapter, ...)
  local basepath = "/sys/class/power_supply/"..adapter.."/"
  for i, name in pairs({...}) do
    file = io.open(basepath..name, "r")
    if file then
      local str = file:read()
      file:close()
      return str
    end
  end
end

--function to read and calculate battery state
function batteryInfo(adapter, widget, battery_widget)

     local fh = io.open("/sys/class/power_supply/"..adapter.."/present", "r")
     local battery_charge_str
     local battery_level_icon
     local charge_type
     local file_ext = ".png"
     if fh == nil then
          battery_level_icon = "battery-100"
          charge_type = "-charging"
          battert_charge_str = "100"
     else
          --calculate the charge percentage
          local current = readBatFile(adapter, "charge_now", "energy_now")
          local capacity = readBatFile(adapter, "charge_full", "energy_full")
          local status = readBatFile(adapter, "status")
          battery_charge_str = math.floor(current * 100 / capacity)



          --convert the charge string to a number
          local battery_charge = tonumber(battery_charge_str)

          --choose the icon to use based on charge
          if (battery_charge >=0 and battery_charge < 15) then battery_level_icon = "battery-low"
          elseif (battery_charge >=40 and battery_charge < 60) then battery_level_icon = "battery-40"
          elseif (battery_charge >=60 and battery_charge < 80) then battery_level_icon = "battery-60"
          elseif (battery_charge >=80 and battery_charge <= 100) then battery_level_icon = "battery-80"
          end

          --determine if the battery is charging or discharging
          if status:match("Charging") then
               charge_type = "-charging"
          elseif status:match("Discharging") then
               charge_type = ""
          else
               -- If we are neither charging nor discharging, assume that we are on A/C
               battery_level_icon = "battery-100"
               charge_type = "-charging"
          end
     end
     --naughty.notify{
          --text = PATH_TO_ICONS .. battery_level_icon .. charge_type .. ".png"
     --}

     battery_widget.icon:set_image(PATH_TO_ICONS .. battery_level_icon .. charge_type .. ".png")


end


return battery_widget
