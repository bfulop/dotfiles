-- See:
--  https://nathansmith.io/posts/neovim-lsp
--  https://rishabhrd.github.io/jekyll/update/2020/09/19/nvim_lsp_config.html
--  https://elianiva.me/post/my-nvim-lsp-setup
--  https://neovim.io/doc/user/lsp.html

local nvim_lsp = require'lspconfig'


-- Custom diagnostic handler for the events and timer API (not yet available).
-- local diagnostic_flags = {
--   signs = {
--     severity_limit = 'Warning',
--   },
--   underline = false,
--   virtual_text = {
--     spacing = 2,
--     severity_limit = 'Warning',
--   },
-- }

-- local diagnostic_config = vim.deepcopy(diagnostic_flags)
-- diagnostic_config.display_diagnostics = false

-- local diagnostic_handler = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, diagnostic_config
-- )

-- function DiagnosticTimer()
--   vim.defer_fn(function()
--     vim.lsp.diagnostic.show_buffer_diagnostics(nil, nil, diagnostic_flags)
--   end, 500)
-- end

-- Custom diagnostic handler.
local diagnostic_handler = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = {
      severity_limit = 'Hint',
    },
    underline = true,
    update_in_insert = true,
    virtual_text = {
      spacing = 2,
      severity_limit = 'Hint',
    },
  }
)

-- Empty diagnostic handler.
local none_diagnostic_handler = function() end

-- Diagnostics symbols for display in the sign column.
vim.cmd('sign define LspDiagnosticsSignError text=✖')
vim.cmd('sign define LspDiagnosticsSignWarning text=✖')
vim.cmd('sign define LspDiagnosticsSignInformation text=●')
vim.cmd('sign define LspDiagnosticsSignHint text=●')

-- On attach function.
local lsp_on_attach = function(client, bufnr)
  -- Update diagnostics when saving the current buffer to disk for the events
  -- and timer API (not yet available).
  -- vim.cmd('autocmd BufWrite <buffer> lua DiagnosticTimer()')

  -- Mappings.
  local opts = {noremap = true, silent = true}
  vim.api.nvim_buf_set_keymap(0, 'n', 'ga','<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(0, 'n', 'gR','<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(0, 'i', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', '<Space>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next({severity_limit = "Warning"})<CR>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev({severity_limit = "Warning"})<CR>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', '<Space>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

  -- nvim LSP Utils extra functions
  require("nvim-lsp-ts-utils").setup {
    disable_commands = false,
    enable_import_on_completion = false
  }

  -- no default maps, so you may want to define some here
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", {silent = true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", ":TSLspFixCurrent<CR>", {silent = true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gR", ":TSLspRenameFile<CR>", {silent = true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", {silent = true})

  -- LSP-based omnifunc.
  --vim.bo.omnifunc = vim.lsp.omnifunc
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- vim.fn.sign_define("LspDiagnosticsSignHint", {texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint"})
  -- vim.fn.sign_define("LspDiagnosticsSignError", {texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError"})
  -- vim.fn.sign_define("LspDiagnosticsSignWarning", {texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning"})
  -- vim.fn.sign_define("LspDiagnosticsSignInformation", {texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation"})
  -- vim.fn.sign_define("LspDiagnosticsSignHint", {texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint"})
  --
  -- Indicate that LSP is ready.
  print('Language server is ready')
end

-- The Language Servers.
-- nvim_lsp.cssls.setup {
--   on_attach = lsp_on_attach,
--   cmd = {'vscode-css-language-server', '--stdio'};
--   filetypes = {'css', 'scss'};
--   handlers = {
--     ['textDocument/publishDiagnostics'] = diagnostic_handler
--   }
-- }

-- nvim_lsp.dartls.setup {
--   on_attach = lsp_on_attach,
--   flags = {allow_incremental_sync = true},
--   init_options = {closingLabels = true},
--   handlers = {
--     ['textDocument/publishDiagnostics'] = diagnostic_handler,
--     ['dart/textDocument/publishClosingLabels'] = require('dart-closing-labels').handler()
--   }
-- }

-- nvim_lsp.html.setup {
--   on_attach = lsp_on_attach,
--   cmd = {'vscode-html-language-server', '--stdio'};
--   filetypes = {'eruby', 'html'};
--   handlers = {
--     ['textDocument/publishDiagnostics'] = diagnostic_handler
--   }
-- }

-- nvim_lsp.solargraph.setup {
--   on_attach = lsp_on_attach,
--   handlers = {
--     ['textDocument/publishDiagnostics'] = none_diagnostic_handler
--   }
-- }

nvim_lsp.tsserver.setup {
  on_attach = lsp_on_attach,
  flags = {debounce_did_change_notify = 300},
  filetypes = { 'javascript', 'typescript', 'typescriptreact' },
  cmd = {'node', '/Users/balintfulop/Install/typescript-language-server/server/lib/cli.js', '--stdio'};
  handlers = {
    ['textDocument/publishDiagnostics'] = diagnostic_handler
  }
}

nvim_lsp.efm.setup {
  default_config = {
    cmd = {
      "efm-langserver",
      "-c",
      [["$HOME/.config/efm-langserver/config.yaml"]]
    }
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact"
  }
}
