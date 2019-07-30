local filesystem = require('gears.filesystem')

return {
  terminal = 'terminator',
  filemanager = 'pcmanfm',
  browser = 'firefox',
  editor = 'atom',
  rofi = 'rofi -show drun -theme ' .. filesystem.get_configuration_dir() .. '/conf/rofi.rasi',
  lock = 'i3lock-fancy-rapid 5 3'
}
