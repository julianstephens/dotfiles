local M = {}

local null_ls = require "null-ls"
local services = require "lsp.null-ls.services"

local is_registered = function(name)
  local query = {
    name = name,
    method = require("null-ls").methods.FORMATTING,
  }
  return require("null-ls.sources").is_registered(query)
end

function M.list_registered_providers(filetype)
  local null_ls_methods = require "null-ls.methods"
  local formatter_method = null_ls_methods.internal["FORMATTING"]
  local registered_providers = services.list_registered_providers_names(filetype)
  return registered_providers[formatter_method] or {}
end


function M.list_configured(formatter_configs)
  local formatters, errors = {}, {}

  for _, fmt_config in ipairs(formatter_configs) do
    local name = fmt_config.exe:gsub("-", "_")
    local formatter = null_ls.builtins.formatting[name]

    if not formatter then
      errors[name] = {} -- Add data here when necessary
    elseif is_registered(fmt_config.exe) then
    else
      local formatter_cmd = services.find_command(formatter._opts.command)
      if not formatter_cmd then
        errors[name] = {} -- Add data here when necessary
      else
        table.insert(
          formatters,
          formatter.with {
            command = formatter_cmd,
            extra_args = fmt_config.args,
            filetypes = fmt_config.filetypes,
          }
        )
      end
    end
  end

  return { supported = formatters, unsupported = errors }
end

function M.setup(formatter_configs)
  if vim.tbl_isempty(formatter_configs) then
    return
  end

  local formatters = M.list_configured(formatter_configs)
  null_ls.register { sources = formatters.supported }
end

return M
