local util = require("vogsphere.util")
local hslutil = require("vogsphere.hsl")
local hsl = hslutil.hslToHex

local M = {}

---@class Palette
M.default = {
  none = hsl(0, 0, 8),

  base04 = hsl(192, 100, 5),
  base03 = hsl(192, 100, 11),
  base02 = hsl(192, 81, 14),
  base01 = hsl(194, 30, 40),
  base00 = hsl(196, 13, 45),
  -- base0 = hsl( 186, 8, 55 ),
  base0 = hsl(0, 0, 90),
  -- base1 = hsl( 180, 7, 60 ),
  base1 = hsl(0, 7, 70),
  base2 = hsl(0, 42, 88),
  base3 = hsl(0, 87, 94),
  base4 = hsl(0, 0, 100),
  yellow = hsl(44, 98, 35),
  yellow100 = hsl(46, 98, 80),
  yellow300 = hsl(44, 98, 50),
  yellow500 = hsl(44, 98, 35),
  yellow700 = hsl(44, 98, 20),
  yellow900 = hsl(44, 98, 10),
  orange = hsl(20, 85, 48),
  orange100 = hsl(20, 100, 70),
  orange300 = hsl(20, 94, 51),
  orange500 = hsl(20, 80, 44),
  orange700 = hsl(20, 81, 35),
  orange900 = hsl(20, 80, 20),
  red = hsl(355, 71, 52),
  red100 = hsl(355, 95, 70),
  red300 = hsl(355, 90, 64),
  red500 = hsl(355, 84, 61),
  red700 = hsl(355, 54, 44),
  red900 = hsl(355, 71, 20),
  -- magenta = hsl(331, 64, 52),
  -- magenta100 = hsl(331, 100, 73),
  -- magenta300 = hsl(331, 86, 64),
  -- magenta500 = hsl(331, 64, 52),
  -- magenta700 = hsl(331, 64, 42),
  -- magenta900 = hsl(331, 65, 20),
  violet = hsl(268, 76, 48),
  violet100 = hsl(268, 76, 90),
  violet300 = hsl(269, 76, 77),
  violet500 = hsl(268, 76, 60),
  violet700 = hsl(268, 76, 50),
  violet900 = hsl(268, 76, 25),
  blue = hsl(195, 69, 49),
  blue100 = hsl(195, 100, 76),
  blue300 = hsl(195, 90, 62),
  blue500 = hsl(195, 83, 43),
  blue700 = hsl(195, 70, 35),
  blue900 = hsl(195, 69, 20),
  grey = hsl(0, 0, 50),
  grey100 = hsl(0, 0, 90),
  grey300 = hsl(0, 0, 60),
  grey500 = hsl(0, 0, 40),
  grey700 = hsl(0, 0, 28),
  grey900 = hsl(0, 0, 15),
  green = hsl(74, 51, 30),
  green100 = hsl(74, 51, 90),
  green300 = hsl(74, 51, 82),
  green500 = hsl(74, 51, 40),
  green700 = hsl(74, 51, 20),
  green900 = hsl(74, 51, 10),

  bg = hsl(0, 0, 8),
  bg_highlight = hsl(192, 100, 11),
  fg = hsl(186, 8, 55),
}

---@return ColorScheme
function M.setup(opts)
  opts = opts or {}
  local config = require("vogsphere.config")

  -- local style = config.is_day() and config.options.light_style or config.options.style
  local style = "default"
  local palette = M[style] or {}
  if type(palette) == "function" then
    palette = palette()
  end

  -- Color Palette
  ---@class ColorScheme: Palette
  local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)

  util.bg = colors.bg
  util.day_brightness = config.options.day_brightness

  colors.black = util.darken(colors.bg, 0.8, "#000000")
  colors.border = colors.black

  -- Popups and statusline always get a dark background
  colors.bg_popup = colors.base04
  colors.bg_statusline = colors.base03

  -- Sidebar and Floats are configurable
  colors.bg_sidebar = config.options.styles.sidebars == "transparent" and colors.none
    or config.options.styles.sidebars == "dark" and colors.base04
    or colors.bg

  colors.bg_float = config.options.styles.floats == "transparent" and colors.none
    or config.options.styles.floats == "dark" and colors.base04
    or colors.bg

  -- colors.fg_float = config.options.styles.floats == "dark" and colors.base01 or colors.fg
  colors.fg_float = colors.fg

  colors.error = colors.red500
  colors.warning = colors.yellow500
  colors.info = colors.blue500
  colors.hint = colors.grey500
  colors.todo = colors.violet500

  config.options.on_colors(colors)
  if opts.transform and config.is_day() then
    util.invert_colors(colors)
  end

  return colors
end

return M
