local compe = require'compe'

compe.setup {
  enabled = true,
  min_length = 2,
  preselect = 'disable',

  source = {
    buffer = {
      filetypes = {
        'javascript'
      }
    },
    nvim_lsp = {
      filetypes = {'javascript', 'typescript'}
    },
  }
}
