local M = {}

function M:setup()
  local status_ok, null_ls = pcall(require, "null-ls")
  if not status_ok then
    return
  end

  null_ls.config(lsp.null_ls.config)
  local default_opts = require("lsp").get_common_opts()

  if vim.tbl_isempty(lsp.null_ls.setup or {}) then
    lsp.null_ls.setup = default_opts
  end

  require("lspconfig")["null-ls"].setup(lsp.null_ls.setup)
end

return M
