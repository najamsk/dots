local naughty = require('naughty')
local beautiful = require('beautiful')
local gears = require('gears')
local awful = require('awful')
-- Naughty presets
naughty.config.padding = 8
naughty.config.spacing = 8

naughty.config.defaults.timeout = 5
naughty.config.defaults.screen = 1
naughty.config.defaults.position = 'bottom_left'
naughty.config.defaults.margin = 16
naughty.config.defaults.ontop = true
naughty.config.defaults.font = 'Roboto Regular 10'
naughty.config.defaults.icon = nil
naughty.config.defaults.icon_size = 48
naughty.config.defaults.shape = gears.shape.rounded_rect
naughty.config.defaults.border_width = 0
naughty.config.defaults.hover_timeout = nil


naughty.config.notify_callback = function(args)

  if args.title and string.match(args.title, "New message from") then
      args.title = "Raven: " .. args.title
      args.icon = "/home/najam/.config/awesome/gotpics/spy.png"
      --awful.spawn{"paplay","/home/najam/.config/awesome/sounds/jamie_hearedyou.wav"}
  elseif args.title and string.match(args.text, "network connection has been") then
    args.icon = "/home/najam/.config/awesome/gotpics/spy.png"
  elseif args.title and string.match(args.title, "Network") then
    args.icon = "/home/najam/.config/awesome/gotpics/minimadking.png"
    --awful.spawn{"paplay","/home/najam/.config/awesome/sounds/jamie_hearedyou.wav"}
  else 
    if args.title then
      args.title = args.title
    end
    args.icon = "/home/najam/.config/awesome/gotpics/jamie2.png"
    -- awful.spawn{"paplay","/home/najam/.config/awesome/sounds/jamie_hearedyou.wav"}
  end
  return args
end

-- Error handling
if _G.awesome.startup_errors then
  naughty.notify(
    {
      preset = naughty.config.presets.critical,
      title = 'Oops, there were errors during startup!',
      text = _G.awesome.startup_errors
    }
  )
end

do
  local in_error = false
  _G.awesome.connect_signal(
    'debug::error',
    function(err)
      if in_error then
        return
      end
      in_error = true

      naughty.notify(
        {
          preset = naughty.config.presets.critical,
          title = 'Oops, an error happened!',
          text = tostring(err)
        }
      )
      in_error = false
    end
  )
end

function log_this(title, txt)
  naughty.notify(
    {
      title = 'log: ' .. title,
      text = txt
    }
  )
end
