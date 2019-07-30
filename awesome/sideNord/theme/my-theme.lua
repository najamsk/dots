local filesystem = require('gears.filesystem')
local mat_colors = require('theme.mat-colors')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'

local theme = {}
theme.icons = theme_dir .. '/icons/'
theme.font = 'Roboto medium 10'

-- Colors Pallets

-- Primary
theme.primary = mat_colors.indigo
theme.primary.hue_500 = '#003f6b'
-- Accent
theme.accent = mat_colors.pink

-- Background
theme.background = mat_colors.blue_grey

theme.background.hue_800 = '#192933'
theme.background.hue_900 = '#121e25'

local awesome_overrides =
  function(theme)
  --[[   theme.dir = os.getenv('HOME') .. '/.config/awesome/theme'
  --theme.dir             = os.getenv("HOME") .. "/code/awesome-pro/themes/pro-dark"

  theme.icons = theme.dir .. '/icons/'
  --theme.wallpaper = theme.dir .. '/wallpapers/pro-dark-shadow.png'
  --theme.wallpaper = os.getenv("HOME") .. '/.config/awesome/themes/holo/wall.png'

  theme.wallpaper = '#000000'
  theme.panel = 'png:' .. theme.icons .. 'tag-list/panel.png'
  theme.font = 'Roboto medium 10'
  theme.title_font = 'Roboto medium 14'
  theme.calendar_font = 'Meslo LGS Regular 10'
  theme.fs_font = 'Meslo LGS Regular 10'

  theme.primary = '#003f6b'
  theme.primary_hue_300 = '#174a78'
  theme.primary_hue_800 = '#00345f'

  theme.accent = '#003f6b'
  theme.accent_hue_300 = '#174a78'
  theme.accent_hue_800 = '#00345f'

  theme.appBackground = '#212121'
  theme.background = '#192933'
  theme.panel_bg = '#192933'

  theme.background_hue_800 = '#121e25'

  theme.fg_normal = '#ffffffde'

  theme.fg_focus = '#e4e4e4'
  theme.fg_urgent = '#CC9393'
  theme.bat_fg_critical = '#232323'

  theme.bg_normal = theme.appBackground
  theme.bg_focus = '#5a5a5a'
  theme.bg_urgent = '#3F3F3F'
  theme.bg_systray = theme.background
  theme.bat_bg_critical = '#ff0000'
  theme.clockgf = '#ffffff'

  -- Borders

  theme.border_width = 2
  theme.border_normal = theme.background
  theme.border_focus = theme.primary_hue_300
  theme.border_marked = '#CC9393'

  -- Menu

  theme.menu_height = 16
  theme.menu_width = 160

  -- Tooltips
  theme.tooltip_bg = '#232323'
  --theme.tooltip_border_color = '#232323'
  theme.tooltip_border_width = 0
  theme.tooltip_shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, 6)
  end

  -- Layout

  theme.layout_max = theme.icons .. 'layouts/arrow-expand-all.png'
  theme.layout_tile = theme.icons .. 'layouts/view-quilt.png'

  -- Taglist

  theme.taglist_bg_empty = 'png:' .. theme.icons .. 'tag-list/unselected.png'
  theme.taglist_bg_occupied = 'png:' .. theme.icons .. 'tag-list/unselected.png'
  theme.taglist_bg_urgent = 'png:' .. theme.icons .. 'tag-list/urgent.png'
  theme.taglist_bg_focus = 'png:' .. theme.icons .. 'tag-list/selected.png'

  -- Tasklist

  theme.tasklist_font = 'Roboto medium 11'
  theme.tasklist_bg_normal = theme.background
  theme.tasklist_bg_focus =
    'linear:0,0:0,48:0,' ..
    theme.background .. ':0.95,' .. theme.background .. ':0.95,' .. theme.fg_normal .. ':1,' .. theme.fg_normal
  theme.tasklist_bg_urgent = theme.primary.hue_800
  theme.tasklist_fg_focus = '#DDDDDD'
  theme.tasklist_fg_urgent = theme.fg_normal
  theme.tasklist_fg_normal = '#AAAAAA'

  -- Misc

  theme.home = theme.dir .. '/icons/magnify.png'
  theme.add = theme.dir .. '/icons/plus.png'

  theme.icon_theme = 'Papirus-Dark'

  --Client
  theme.border_width = 2
  theme.border_focus = theme.primary.hue_500
  theme.border_normal = theme.background.hue_800 ]]
end
return {
  theme = theme,
  awesome_overrides = awesome_overrides
}
