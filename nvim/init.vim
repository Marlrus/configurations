call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'neovim/nvim-lspconfig', 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'liuchengxu/vim-which-key'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'wookayin/fzf-ripgrep.vim'
Plug 'sbdchd/neoformat'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vividchalk'
Plug 'bignimbus/pop-punk.vim'
Plug 'airblade/vim-gitgutter'
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
Plug 'balanceiskey/vim-framer-syntax'
Plug 'bluz71/vim-moonfly-colors'
Plug 'agude/vim-eldar'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'mbbill/undotree'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mxsdev/nvim-dap-vscode-js'
Plug 'nvim-neotest/nvim-nio'
Plug 'nvim-neotest/nvim-nio'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

call plug#end()

syntax on

set mouse=
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
" set colorcolumn=100
" highlight ColorColumn ctermbg=238

colorscheme pop-punk
" colorscheme eldar
" colorscheme vividchalk
" colorscheme jellybeans
" colorscheme gruvbox

" lua vim.o.ls = 0
" lua vim.o.ch = 0
" ========== Autogroup ===========
" augroup MARLRUS
" " Auto format
"   autocmd!
"   autocmd BufWritePre * Neoformat
" augroup END

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

" Floaterm Related
nnoremap <leader>pt :FloatermNew<CR>
nnoremap <leader>pc :FloatermNew --cwd %:h<CR>

" Git Related
nnoremap <leader>gv :FloatermNew lazygit<CR>

nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>pu :UndotreeToggle<CR>

" Git fugitive Merge Conflict
nnoremap <leader>gs :G<CR>
nnoremap <leader>gh :diffget //3<CR>
nnoremap <leader>gu :diffget //2<CR>

nmap <leader>gc <Plug>(GitGutterPreviewHunk)
nmap <leader>gn <Plug>(GitGutterNextHunk)
nmap <leader>gN <Plug>(GitGutterPrevHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)

" move line up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==

" WhichKey
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" Spell Check related
nnoremap <leader>es :set spell spelllang=es<CR>
nnoremap <leader>en :set spell spelllang=en<CR>
nnoremap <leader>ee :set spell spelllang=en,es<CR>
nnoremap <leader>eu :set nospell<CR>
nnoremap <leader>s ]s
nnoremap <leader>S [s
nnoremap <leader>z z=

" Macro on visual
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Floaterm
let g:floaterm_width=0.9
let g:floaterm_height=0.9
let g:floaterm_autoclose=1
let g:floaterm_opener='edit'

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

" =========== Completion menu settings and strategy =================

" =========== Nvim CMP ===========

:lua << EOF
-- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    capabilities = capabilities
  }
EOF

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
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  end
  local servers = {'jsonls', 'ts_ls', 'cssls', 'graphql', 'yamlls', 'bashls', 'vimls', 'html', 'terraformls', 'gopls', 'docker_compose_language_service', 'dockerls', 'eslint', 'nxls'}
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

-- JS/TS Debugger Config
  local dap, dapui = require("dap"), require("dapui")
  dapui.setup()
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end

  for _, language in ipairs({ "typescript", "javascript" }) do
    dap.configurations[language] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        address = "localhost",
        name = "Auto Attach To Localhost Default",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to Process",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      }
    }
  end

  require("dap-vscode-js").setup({
    -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    debugger_path = "/home/marlrus/.dotfiles/vscode-js-debug", -- Path to vscode-js-debug installation.
    -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
    -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
    -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
    -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
  })
EOF

"LSP diagnostics Keybinds
nmap <leader>n :lua vim.diagnostic.goto_next()<CR>
nmap <leader>N :lua vim.diagnostic.goto_prev()<CR>

nnoremap <leader>f :Neoformat<CR>
xnoremap <leader>f :Neoformat<CR>

"Debugger Mapper
nmap <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nmap <leader>dc :lua require'dap'.continue()<CR>
nmap <leader>dt :lua require'dap'.terminate()<CR>
nmap <leader>dso :lua require'dap'.step_over()<CR>
nmap <leader>dsi :lua require'dap'.step_into()<CR>
