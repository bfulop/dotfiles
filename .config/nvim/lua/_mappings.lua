local leader = "\\"
local g = vim.g
local utils = require('_utils')
local api = vim.api

--SET LEADER GLOBALLY
-- g.mapleader = ' '

--TELESCOPE MAPPINGS
utils.nnoremap(leader..'p', ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'p', ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<cr>")
utils.nnoremap(leader..'S', ":lua require'telescope.builtin'.oldfiles(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'S', ":lua require'telescope.builtin'.oldfiles(require('telescope.themes').get_dropdown({}))<cr>")
utils.nnoremap(leader..'G', ":lua require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'G', ":lua require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({}))<cr>")
utils.nnoremap(leader..'b', ":lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'b', ":lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({}))<cr>")
utils.nnoremap(leader..'c', ":lua require'telescope.builtin'.commands(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'c', ":lua require'telescope.builtin'.commands(require('telescope.themes').get_dropdown({}))<cr>")
utils.nnoremap(leader..'v', ":lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'v', ":lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown({}))<cr>")

utils.nnoremap(leader..'5', ":Startify<cr>")
utils.vnoremap(leader..'5', ":Startify<cr>")
utils.nnoremap(leader..'4', ":lua require'telescope.builtin'.man_pages(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'4', ":lua require'telescope.builtin'.man_pages(require('telescope.themes').get_dropdown({}))<cr>")
utils.nnoremap(leader..'3', ":lua require'telescope.builtin'.symbols(require('telescope.themes').get_dropdown({sources = {'emoji'}}))<cr>")
utils.vnoremap(leader..'3', ":lua require'telescope.builtin'.symbols(require('telescope.themes').get_dropdown({sources = {'emoji'}}))<cr>")
utils.nnoremap(leader..'2', ":lua require'telescope.builtin'.help_tags(require('telescope.themes').get_dropdown({}))<cr>")
utils.vnoremap(leader..'2', ":lua require'telescope.builtin'.help_tags(require('telescope.themes').get_dropdown({}))<cr>")
utils.noremap('',leader..'1', ":lua require'telescope.builtin'.builtin()<cr>")
