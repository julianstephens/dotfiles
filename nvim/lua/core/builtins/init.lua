local M = {}

local builtins = {
  "plugin.which-key",
  "plugin.gitsigns",
  "plugin.cmp",
  "plugin.dashboard",
  "plugin.dap",
  "plugin.terminal",
  "plugin.telescope",
  "plugin.treesitter",
  "plugin.nvimtree",
  "plugin.project",
  "plugin.bufferline",
  "plugin.autopairs",
  "plugin.comment",
  "plugin.notify",
  "plugin.lualine",
}

function M.config(config)
  for _, builtin_path in ipairs(builtins) do
    local builtin = require(builtin_path)
    builtin.config(config)
  end
end

return M
