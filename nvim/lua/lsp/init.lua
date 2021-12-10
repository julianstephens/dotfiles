local M = {}

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function lsp_code_lens_refresh(client)
  if client.resolved_capabilities.code_lens then
    vim.api.nvim_exec(
      [[
      augroup lsp_code_lens_refresh
        autocmd! * <buffer>
        autocmd InsertLeave <buffer> lua vim.lsp.codelens.refresh()
        autocmd InsertLeave <buffer> lua vim.lsp.codelens.display()
      augroup END
    ]],
      false
    )
  end
end

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  end

  return capabilities
end

local function select_default_formater(client)
  if client.name == "null-ls" or not client.resolved_capabilities.document_formatting then
    return
  end
  local formatters = require "lvim.lsp.null-ls.formatters"
  local client_filetypes = client.config.filetypes or {}
  for _, filetype in ipairs(client_filetypes) do
    if #vim.tbl_keys(formatters.list_registered_providers(filetype)) > 0 then
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end
  end
end

function M.common_on_init(client, bufnr)
  if lsp.on_init_callback then
    lsp.on_init_callback(client, bufnr)
    return
  end
  select_default_formater(client)
end

function M.common_on_attach(client, bufnr)
  if lsp.on_attach_callback then
    lsp.on_attach_callback(client, bufnr)
  end
  lsp_highlight_document(client)
  lsp_code_lens_refresh(client)
  add_lsp_buffer_keybindings(bufnr)
end

function M.get_common_opts()
  return {
    on_attach = M.common_on_attach,
    on_init = M.common_on_init,
    capabilities = M.common_capabilities(),
  }
end

local LSP_DEPRECATED_SIGN_MAP = {
  ["DiagnosticSignError"] = "LspDiagnosticsSignError",
  ["DiagnosticSignWarn"] = "LspDiagnosticsSignWarning",
  ["DiagnosticSignHint"] = "LspDiagnosticsSignHint",
  ["DiagnosticSignInfo"] = "LspDiagnosticsSignInformation",
}

function M.setup()
  local lsp_status_ok, _ = pcall(require, "lspconfig")
  if not lsp_status_ok then
    return
  end

  local is_neovim_5 = vim.fn.has "nvim-0.6" ~= 1

  for _, sign in ipairs(lsp.diagnostics.signs.values) do
    local lsp_sign_name = LSP_DEPRECATED_SIGN_MAP[sign.name]
    if is_neovim_5 and lsp_sign_name then
      vim.fn.sign_define(lsp_sign_name, { texthl = lsp_sign_name, text = sign.text, numhl = lsp_sign_name })
    end
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  require("lvim.lsp.handlers").setup()

  require("lsp.null-ls").setup()

  require("core.autocmds").configure_format_on_save()
end
