local colors = require("vogsphere.colors").setup({ transform = true })
local config = require("vogsphere.config").options

local vogsphere = {}

vogsphere.normal = {
  a = { bg = colors.blue, fg = colors.black },
  b = { bg = colors.base0, fg = colors.base04 },
  c = { bg = colors.bg_statusline, fg = colors.fg },
}

vogsphere.insert = {
  a = { bg = colors.green300, fg = colors.black },
}

vogsphere.command = {
  a = { bg = colors.yellow500, fg = colors.black },
}

vogsphere.visual = {
  a = { bg = colors.grey, fg = colors.black },
}

vogsphere.replace = {
  a = { bg = colors.red, fg = colors.black },
}

vogsphere.terminal = {
  a = { bg = colors.black, fg = colors.grey100 },
}

vogsphere.inactive = {
  a = { bg = colors.bg_statusline, fg = colors.blue },
  b = { bg = colors.bg_statusline, fg = colors.fg, gui = "bold" },
  c = { bg = colors.bg_statusline, fg = colors.fg },
}

if config.lualine_bold then
  for _, mode in pairs(vogsphere) do
    mode.a.gui = "bold"
  end
end

return vogsphere
