local awful = require('awful')
local iconPath = os.getenv('HOME') .. '/.config/awesome/theme/icons/tag-list/tag/'
local gears = require('gears')

local tags = {
    {
        icon = 'firefox.png',
        type = 'firefox',
        defaultApp = 'firefox',
        screen = 1
    },
    {
        icon = 'console-line.png',
        type = 'any',
        defaultApp = 'terminator',
        screen = 1
    },
    {
        icon = 'code-braces.png',
        type = 'code',
        defaultApp = 'code',
        screen = 1
    },
    {
        icon = 'folder.png',
        type = 'files',
        defaultApp = 'pcmanfm',
        screen = 1
    },
    {
        icon = 'forum.png',
        type = 'social',
        defaultApp = 'station',
        screen = 1
    },
    {
        icon = 'evernote.png',
        type = 'notes',
        defaultApp = '',
        screen = 1
    },
    {
        icon = 'ninja.png',
        type = 'any',
        defaultApp = '',
        screen = 1
    },
    {
        icon = 'video.png',
        type = 'any',
        defaultApp = 'vlc',
        screen = 1
    },
    {
        icon = 'magnet.png',
        type = 'any',
        defaultApp = 'deluge',
        screen = 1
    },
    {
        icon = 'stethoscope.png',
        type = 'any',
        defaultApp = '',
        screen = 1
    }
}

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating,
}

awful.screen.connect_for_each_screen(
    function(s)
        for i, tag in pairs(tags) do
            local new_tag =
                awful.tag.add(
                i,
                {
                    icon = iconPath .. tag.icon,
                    icon_only = true,
                    layout = awful.layout.suit.tile,
                    gap_single_client = false,
                    gap = 4,
                    screen = s,
                    defaultApp = tag.defaultApp,
                    selected = i == 1
                }
            )
        end
    end
)

tag.connect_signal(
    'property::layout',
    function(t)
        local currentLayout = awful.tag.getproperty(t, 'layout')
        if (currentLayout == awful.layout.suit.max) then
            t.gap = 0
        else
            t.gap = 4
        end
    end
)
