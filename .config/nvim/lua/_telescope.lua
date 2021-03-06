local actions = require('telescope.actions')
local telescope = require('telescope')
telescope.setup{
    defaults = {
        mappings = {i = {["<esc>"] = actions.close, }},
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },
        prompt_position = "top",
        prompt_prefix = ">",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_defaults = {
            -- TODO add builtin options.
        },
        file_sorter =  require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {"Session.vim", ".snowpack", "*.d.ts", "*lock.json", ".backup",".swap",".langservers",".session",".undo","*.git","node_modules","vendor",".cache",".vscode-server",".Desktop",".Documents", "tags", "dist", "^build", "ressources", "package-lock.json", "yarn.lock", "yarn-error.log", "*.log", "deploy", "*.lock", ".gif", ".jpg", ".png", ".jpeg", "__snapshots__"},
        generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
        shorten_path = true,
        winblend = 0,
        width = 0.75,
        preview_cutoff = 120,
        results_height = 1,
        results_width = 0.8,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require'telescope.previewers'.cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
        grep_previewer = require'telescope.previewers'.vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
        qflist_previewer = require'telescope.previewers'.qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`

        -- Developer configurations: Not meant for general override
        -- buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },

}

vim.cmd[[highlight TelescopeBorder guifg=#4c4c4c]]
vim.cmd[[highlight TelescopeSelection guifg=#ffffff guibg=#393939 gui=bold]]
vim.cmd[[highlight TelescopeSelectionCaret guifg=#749484 gui=bold]]

-- require('telescope').load_extension('fzy_native')
pcall(require('telescope').load_extension, 'fzy_native')
