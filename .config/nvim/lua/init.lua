local init = function()

local neoscroll = require('neoscroll')

neoscroll.setup({
  mappings = {'<C-u>', '<C-d>', '<C-b>',
    '<C-f>', '<C-y>', '<C-e>', 'zz'},
  hide_cursor = true,          
  stop_eof = false,             
  respect_scrolloff = true,   
  cursor_scrolls_alone = true,  
})
--
-- MY CONFS
-- require('_plugins')
-- require('_theme')
require('_mappings')
-- require('_options')


--LIBRARIES
require('_utils')

--PLUGINS
require('_compe-config')
-- require('_quickscope')
require('_hexokinase')
require('_telescope')
require('_treesitter')
--require('_nvimtree')
require('_galaxyline')

--LSP
require('_lsp-config')

end

init()
