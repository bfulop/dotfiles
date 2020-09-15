set nonumber
set ignorecase
set smartcase
" set relativenumber
set expandtab
set tabstop=2
set shiftwidth=2
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=6
set foldnestmax=8
set nocompatible
set inccommand=nosplit
" needed for limelight on Gui apps
set termguicolors
filetype plugin on
syntax on
set updatetime=200

set hidden
set cmdheight=2
set signcolumn=yes
set noshowmode
" set laststatus=2
" parcel hot module reload (?):
set backupcopy=yes

" Maintain undo history between sessions
set undofile 
set undodir=~/Temp/undodir

" don't give |ins-completion-menu| messages.
set shortmess+=c
" show number of search results
set shortmess-=S

let $PATH .= ':/Users/balintfulop/.nodenv/versions/14.8.0/bin/'

let g:ale_disable_lsp = 1
let g:ale_fixers = {
\  'javascript': ['prettier'],
\}
let g:ale_completion_enabled = 0
let g:ale_javascript_prettier_use_global = 1
let g:ale_sign_error = '!'
let g:ale_sign_warning = '◆'

call plug#begin('~/config/.nvim/plugged')
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-lua/diagnostic-nvim'
  Plug 'steelsojka/completion-buffers'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'dense-analysis/ale'
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/fern-git-status.vim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/telescope.nvim'
  Plug 'sgur/vim-editorconfig'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
  Plug 'haya14busa/vim-keeppad'
  Plug 'jesseleite/vim-noh'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'tmsvg/pear-tree'
  Plug 'justinmk/vim-dirvish'
  Plug 'machakann/vim-highlightedyank'
  Plug 'wellle/targets.vim'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-projectionist'
  " Plug 'sheerun/vim-polyglot'
  Plug 'prettier/vim-prettier', { 'do': 'npm install',  'branch': 'release/0.x'  }
  Plug 'plasticboy/vim-markdown'
  Plug 'elzr/vim-json'
  " Plug 'reedes/vim-pencil'
  " Plug 'tpope/vim-commentary'
  Plug 'tomtom/tcomment_vim'
  Plug 'machakann/vim-sandwich'
  " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  " Plug 'junegunn/fzf.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'aereal/vim-colors-japanesque'
  " Plug 'AlessandroYorba/Despacio'
  " Plug 'BrainDeath0/Hypsteria'
  Plug 'yuttie/inkstained-vim'
  Plug 'kyazdani42/blue-moon'
  " Plug 'vim-scripts/Sift'
  " Plug 'equalsraf/neovim-gui-shim'
  Plug 'psliwka/vim-smoothie'
  " Plug 'akiyosi/gonvim-fuzzy'
  " Plug 'metakirby5/codi.vim'
call plug#end()

lua <<EOF
local nvim_lsp = require'nvim_lsp'

local on_attach = function()
  require'diagnostic'.on_attach()
  require'completion'.on_attach()
end

nvim_lsp.tsserver.setup {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    root_dir = nvim_lsp.util.root_pattern("package.json", "tsconfig.json", ".git"),
    on_attach = on_attach
}

require'nvim-treesitter.configs'.setup {
  ensure_insalled = "all",
  highlight = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}

-- Attach to certain Filetypes, add special configuration for `html`
-- Use `background` for everything else.
require 'colorizer'.setup {
  css = {
    css = true;
  };
  scss = {
   css = true;
  };
  'javascript';
  html = {
    mode = 'foreground';
  }
}
EOF

" Neovim LSP features
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" telescope plugin
nnoremap <Leader>p :lua require'telescope.builtin'.git_files{}<CR>
nnoremap ar <cmd>lua require'telescope.builtin'.lsp_document_symbols{ shorten_path = true }<CR>
nnoremap <silent> gw <cmd>lua require'telescope.builtin'.lsp_workspace_symbols{}<CR>
nnoremap <Leader>v :lua require'telescope.builtin'.live_grep{}<CR>
nnoremap <silent> gr <cmd>lua require'telescope.builtin'.lsp_references{ shorten_path = true }<CR>

" Window action remaps
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Dirvish settings
let g:dirvish_mode = ':sort ,^.*[\/],'
noremap <Leader>t :Dirvish<cr>
noremap <Leader>c :Dirvish %<cr>
nmap <Leader>a <Plug>(dirvish_up)

" Fern
noremap <silent> <Leader>d :Fern . -drawer -width=35 -toggle<CR>
noremap <silent> <Leader>f :Fern . -drawer -reveal=% -width=35<CR>
noremap <silent> <Leader>. :Fern %:h -drawer -width=35<CR>

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> m <Plug>(fern-action-mark-toggle)j
  nmap <buffer> N <Plug>(fern-action-new-file)
  nmap <buffer> K <Plug>(fern-action-new-dir)
  nmap <buffer> D <Plug>(fern-action-remove)
  nmap <buffer> R <Plug>(fern-action-move)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> <nowait> d <Plug>(fern-action-hidden-toggle)j
  nmap <buffer> <nowait> < <Plug>(fern-action-leave)
  nmap <buffer> <nowait> > <Plug>(fern-action-enter)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

let g:fern#mark_symbol                       = '●'
let g:fern#renderer#default#collapsed_symbol = '▷ '
let g:fern#renderer#default#expanded_symbol  = '▼ '
let g:fern#renderer#default#leading          = ' '
let g:fern#renderer#default#leaf_symbol      = ' '
let g:fern#renderer#default#root_symbol      = '~ '

" Terminal mode escape
tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>

" Pear tree don't erase temporarly the closing brackets
let g:pear_tree_repeatable_expand = 0

" Lightline config for narrow windows
let g:lightline = {
      \ 'colorscheme': 'inkstained',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             ['guten', 'buffernum', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'filetype' ] ]
      \ },
      \ 'component': {
      \   'buffernum': '%n'
      \ },
      \ 'component_function': {
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFileformat()
  return winwidth(0) > 400 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 100 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" nvim-lua/diagnostic

let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_auto_popup_while_jump = 1
let g:diagnostic_enable_underline = 1

" nvim-lua/completion settings START

let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'buffers']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" nvim-lua/completion settings --------------- END


au BufRead,BufNewFile *.cjs		set filetype=javascript
autocmd BufNewFile,BufRead *.js set filetype=javascript
let g:jsx_ext_required = 1

set background=light
colorscheme my-inkstained
" cursor
set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50

" Limelight start on startup
" autocmd VimEnter * Limelight
let g:limelight_default_coefficient = 0.7
" Color name (:help cterm-colors) or ANSI code
" let g:limelight_conceal_ctermfg = 'gray'
" let g:limelight_conceal_ctermfg = 240

" " Color name (:help gui-colors) or RGB color
" let g:limelight_conceal_guifg = 'DarkGray'
" let g:limelight_conceal_guifg = '#777777'

" projectionist
let g:projectionist_heuristics = {
      \  "src/*.js": {
      \ "type": "source",
      \ "alternate": "src/{}.test.js"
      \ },
      \ "src/*.test.js": {
      \ "type": "test",
      \ "alternate": "src/{}.js"
      \ }
      \ }

" augroup pencil
"   autocmd!
"   autocmd FileType markdown,mkd call pencil#init()
"   autocmd FileType text         call pencil#init()
" augroup END

let g:vim_markdown_fenced_languages = ['JSON=json']
set conceallevel=2
au FileType markdown set conceallevel=2
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_conceal_code_start = 0
let g:vim_markdown_conceal_code_end = 0
" let g:pencil#conceallevel = 2

