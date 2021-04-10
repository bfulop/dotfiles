set nonumber
set ignorecase
set smartcase
" set relativenumber
set expandtab
set tabstop=2
set shiftwidth=2
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=8
set nocompatible
set inccommand=nosplit
" needed for limelight on Gui apps
set termguicolors
filetype plugin on
syntax on
set updatetime=100

set hidden
set cmdheight=2
set signcolumn=yes
set noshowmode
" set laststatus=2
" parcel hot module reload (?):
set backupcopy=yes
set history=300
set undolevels=300
set autoindent
set noswapfile

" Maintain undo history between sessions
set undofile 
set undodir=~/Temp/undodir

" don't give |ins-completion-menu| messages.
set shortmess+=c
" show number of search results
set shortmess-=S
" vim-lsc avoid suppressing error messages from this plugin.
set shortmess-=F

let $PATH .= ':/Users/balintfulop/.nodenv/versions/15.5.1/bin/'

if !exists('g:vscode')
let g:ale_disable_lsp = 1
let g:ale_fixers = {
\  'javascript': ['prettier', 'eslint'],
\  'typescript': ['prettier', 'eslint'],
\  'typescriptreact': ['prettier', 'eslint'],
\}
let g:ale_completion_enabled = 0
let g:ale_javascript_prettier_use_global = 1
let g:ale_sign_error = '!'
let g:ale_sign_warning = '◆'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
let g:ale_lint_delay = 2000
nnoremap <Leader>ll    <cmd>ALELint<CR>
endif

call plug#begin('~/config/.nvim/plugged')
if !exists('g:vscode')
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  Plug 'vim-utils/vim-troll-stopper'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'nvim-treesitter/nvim-treesitter-refactor'
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'nvim-treesitter/completion-treesitter'
  " Plug 'dense-analysis/ale'
  Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
  Plug 'lambdalisue/fern.vim'
  Plug 'mhartington/formatter.nvim'
  Plug 'lambdalisue/fern-git-status.vim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/telescope.nvim'
  Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }
  Plug 'editorconfig/editorconfig-vim'
  Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'andymass/vim-matchup'
  " Plug 'airblade/vim-gitgutter'
  Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
  Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
  Plug 'kyazdani42/nvim-web-devicons' 
  Plug 'haya14busa/vim-keeppad'
  Plug 'jesseleite/vim-noh'
  Plug 'tmsvg/pear-tree'
  Plug 'justinmk/vim-dirvish'
  Plug 'prettier/vim-prettier', { 'do': 'npm install',  'branch': 'release/0.x'  }
  Plug 'plasticboy/vim-markdown'
  Plug 'elzr/vim-json'
  " Plug 'sheerun/vim-polyglot'
  " Plug 'reedes/vim-pencil'
  " Plug 'tpope/vim-commentary'
  Plug 'tomtom/tcomment_vim'
  Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
  " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  " Plug 'junegunn/fzf.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'aereal/vim-colors-japanesque'
  " Plug 'AlessandroYorba/Despacio'
  " Plug 'BrainDeath0/Hypsteria'
  Plug 'yuttie/inkstained-vim'
  Plug 'kyazdani42/blue-moon'
  " Plug 'vim-scripts/Sift'
  " Plug 'equalsraf/neovim-gui-shim'
  Plug 'karb94/neoscroll.nvim'
  " Plug 'akiyosi/gonvim-fuzzy'
  " Plug 'metakirby5/codi.vim'
  Plug 'machakann/vim-highlightedyank'
endif
  Plug 'wellle/targets.vim'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-projectionist'
  Plug 'machakann/vim-sandwich'
call plug#end()

" Disable 'trim_trailing_whitespace' rule since it does not place nice with
" snippet expansions.
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']

" Disable sources that are not needed to improve startup time:
" https://is.gd/4keyXX
let g:loaded_compe_calc = 0
let g:loaded_compe_emoji = 0
let g:loaded_compe_luasnip = 0
let g:loaded_compe_nvim_lua = 0
let g:loaded_compe_path = 0
let g:loaded_compe_snippets_nvim = 0
let g:loaded_compe_spell = 0
let g:loaded_compe_tags = 0
let g:loaded_compe_treesitter = 0

let g:matchup_matchparen_offscreen = {'method': 'popup'}

if !exists('g:vscode')
  " Load Neovim Lua-based plugin configurations.
if has('nvim')
  lua require("init")
    augroup ScrollbarInit
      autocmd!
      autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
      autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
      autocmd WinLeave,FocusLost             * silent! lua require('scrollbar').clear()
    augroup end
endif
lua <<EOF
require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {
        -- prettier
       function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'},
            stdin = true
          }
        end
    },
    typescript = {
        -- prettier
       function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'},
            stdin = true
          }
        end
    },
  }
})
EOF
endif

nnoremap <silent> <leader>f :Format<CR>

if !exists('g:vscode')

" telescope plugin
" nnoremap ar <cmd>lua require'telescope.builtin'.lsp_document_symbols{ shorten_path = true }<CR>
" nnoremap <silent> gw <cmd>lua require'telescope.builtin'.lsp_workspace_symbols{}<CR>
" nnoremap <silent> gr <cmd>lua require'telescope.builtin'.lsp_references{ shorten_path = true }<CR>
nnoremap <Leader>q <cmd>lua require'telescope.builtin'.quickfix{}<CR>
nnoremap <Leader>ff <cmd>lua require'telescope.builtin'.help_tags{}<CR>

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

nnoremap <Plug>(fern-close-drawer) :<C-u>FernDo close -drawer -stay<CR>
nmap <buffer><silent> <Plug>(fern-action-open-and-close)
      \ <Plug>(fern-action-open)
      \ <Plug>(fern-close-drawer)

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
set conceallevel=0
au FileType markdown set conceallevel=0
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_conceal_code_start = 0
let g:vim_markdown_conceal_code_end = 0
" let g:pencil#conceallevel = 2

endif
