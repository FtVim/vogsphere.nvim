local util = require("vogsphere.util")
local theme = require("vogsphere.theme")
local config = require("vogsphere.config")

local M = {}

function M._load(style)
  if style and not M._style then
    M._style = require("vogsphere.config").options.style
  end
  if not style and M._style then
    require("vogsphere.config").options.style = M._style
    M._style = nil
  end
  M.load({ style = style, use_background = style == nil })
end

---@param opts Config|nil
function M.load(opts)
  if opts then
    require("vogsphere.config").extend(opts)
  end
  util.load(theme.setup())
end

M.setup = config.setup

-- keep for backward compatibility
M.colorscheme = M.load

return M
