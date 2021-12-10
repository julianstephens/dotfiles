--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Bash
require'lspconfig'.bashls.setup {}

-- CSS/SCSS/Less
require'lspconfig'.ccls.setup {
    capabilities = capabilities,
}

-- Diagnostics
require'lspconfig'.diagnosticls.setup {
    filetypes = {"javascript", "javascriptreact", "typescript", "typscriptreact", "css", "scss"},
      init_options = {
    filetypes = {
      javascript = "eslint",
      typescript = "eslint",
      javascriptreact = "eslint",
      typescriptreact = "eslint"
    },
    linters = {
      eslint = {
        sourceName = "eslint",
        command = "./node_modules/.bin/eslint",
        rootPatterns = {
          ".eslitrc.js",
          "package.json"
        },
        debounce = 100,
        args = {
          "--cache",
          "--stdin",
          "--stdin-filename",
          "%filepath",
          "--format",
          "json"
        },
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${ruleId}]",
          security = "severity"
        },
        securities = {
          [2] = "error",
          [1] = "warning"
        }
      }
    }
  }
}

-- Emmet
require'lspconfig'.emmet_ls.setup {
    filetypes = {"html", "css", "scss"}
}

-- Eslint
-- vim.api.nvim_exec(
--     [[ autocmd BufWritePre <buffer> <cmd>EslintFixAll<CR>]], 
--     false
-- )
-- require'lspconfig'.eslint.setup{}

-- HTML
require'lspconfig'.html.setup {
  capabilities = capabilities,
}

-- JSON
require'lspconfig'.jsonls.setup {
    capabilities = capabilities,
}

-- Typescript
require'lspconfig'.tsserver.setup{}

-- Vim
require'lspconfig'.vimls.setup{}
