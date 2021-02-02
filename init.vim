call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-lsp' 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'liuchengxu/vim-which-key'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'wookayin/fzf-ripgrep.vim'
Plug 'sbdchd/neoformat'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vividchalk'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
Plug 'balanceiskey/vim-framer-syntax'
Plug 'bluz71/vim-moonfly-colors'
Plug 'agude/vim-eldar'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

call plug#end()

syntax on

let mapleader = " "
set pyx=3
set clipboard=unnamedplus
set expandtab
set tabstop=2 softtabstop=2
set shiftwidth=2
set nu rnu
set smartindent
" Block blinking cursor :help 'cursor'
set guicursor=n-v-c-i:block,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175
" set hidden
set noerrorbells
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=15
set signcolumn=yes
set updatetime=100
set termguicolors


colorscheme eldar

" ========== Autogroup ===========
augroup MARLRUS
" Auto format
  autocmd!
  autocmd BufWritePre * Neoformat
augroup END

" =====  Remaps =====

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>k :wincmd k<CR>

nnoremap <leader>ps :Rg<CR>
nnoremap <leader>pv :FloatermNew --height=0.9 ranger<CR>
nnoremap <leader>pp :GFiles<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <leader>pb :Buffers<CR>
nnoremap <leader>gv :FloatermNew lazygit<CR>

nnoremap <leader>gb :Git blame<CR>

" move line up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==

" WhichKey
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" Floaterm
let g:floaterm_width=0.9
let g:floaterm_height=0.9
let g:floaterm_autoclose=1

" RG settings
if executable('rg')
  let g:rg_derive_root='true'
" how the command will be executed
" let g:rg_command='rg --hidden'
endif

" Vim-gitgutter
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 1
highlight! link SignColumn LineNr

nmap <leader>gc <Plug>(GitGutterPreviewHunk)
nmap <leader>gn <Plug>(GitGutterNextHunk)
nmap <leader>gN <Plug>(GitGutterPrevHunk)

" =========== Completion menu settings and strategy =================

" Use depolete.
let g:deoplete#enable_at_startup = 1
" set priority in selection
call deoplete#custom#source('neosnippet', 'rank', 1000)
set completeopt=menu,noselect,noinsert
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" Move through snippets using tab
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" disable default snippets from neosnippets
let g:neosnippet#disable_runtime_snippets = {'_' : 1}
" Custom snippet directory
let g:neosnippet#snippets_directory = '~/.config/nvim/snippets'
" select snippets and move between points in snippet
imap <c-s>     <Plug>(neosnippet_expand_or_jump)
smap <c-s>     <Plug>(neosnippet_expand_or_jump)
xmap <c-s>     <Plug>(neosnippet_expand_target)

" ============== LSP RELATED ===============

"" require('completion').on_attach() add this to use completion-nvim
:lua << EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(_, bufnr)
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  end
  local servers = {'jsonls', 'tsserver', 'cssls', 'html', 'graphql', 'yamlls', 'bashls', 'vimls' }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
  end

-- Diag config enable use of ctrl c remove underline err

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      signs = true,
      update_in_insert = true,
    }
  )
EOF

"LSP diagnostics Keybinds
nmap <leader>n :lua vim.lsp.diagnostic.goto_next()<CR>
nmap <leader>N :lua vim.lsp.diagnostic.goto_prev()<CR>
