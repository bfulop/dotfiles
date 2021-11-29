local init = function()

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
-- require('_telescope')
require('_treesitter')
-- require('_lualine')
--require('_nvimtree')
-- require('_galaxyline')

--LSP
require('_lsp-config')

end

init()
