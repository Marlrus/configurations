-- =========== Plugins (vim-plug) ===========
local plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/autoload/plugged')

plug('junegunn/fzf', { ['do'] = function() vim.fn['fzf#install']() end })
plug('junegunn/fzf.vim')
plug('voldikss/vim-floaterm')
plug('liuchengxu/vim-which-key', { ['on'] = {'WhichKey', 'WhichKey!'} })
plug('wookayin/fzf-ripgrep.vim')
plug('sbdchd/neoformat')
plug('jiangmiao/auto-pairs')
plug('tpope/vim-surround')
plug('tpope/vim-repeat')
plug('tpope/vim-commentary')
plug('tpope/vim-fugitive')
-- Colorschemes (uncomment to switch)
plug('tpope/vim-vividchalk')
plug('bignimbus/pop-punk.vim')
plug('zootedb0t/citruszest.nvim')
plug('nyngwang/nvimgelion')
plug('aperezdc/vim-elrond')
plug('balanceiskey/vim-framer-syntax')
plug('bluz71/vim-moonfly-colors')
plug('agude/vim-eldar')
plug('airblade/vim-gitgutter')
plug('styled-components/vim-styled-components', { branch = 'main' })
plug('mbbill/undotree')
plug('mfussenegger/nvim-dap')
plug('rcarriga/nvim-dap-ui')
plug('mxsdev/nvim-dap-vscode-js')
plug('nvim-neotest/nvim-nio')
plug('hrsh7th/cmp-nvim-lsp')
plug('hrsh7th/cmp-buffer')
plug('hrsh7th/cmp-path')
plug('hrsh7th/cmp-cmdline')
plug('hrsh7th/nvim-cmp')

vim.call('plug#end')

-- =========== General Settings ===========

vim.cmd('syntax on')

vim.o.mouse = ''
vim.g.mapleader = ' '
vim.o.clipboard = 'unnamedplus'
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.number = true
vim.o.relativenumber = true
vim.o.smartindent = true
vim.o.errorbells = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.o.undofile = true
vim.o.incsearch = true
vim.o.scrolloff = 15
vim.o.signcolumn = 'yes'
vim.o.updatetime = 100
vim.o.termguicolors = true

-- Block blinking cursor
vim.o.guicursor = 'n-v-c-i:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'

-- vim.o.ls = 0
-- vim.o.ch = 0
-- vim.o.colorcolumn = '100'

-- =========== Colorscheme ===========

vim.cmd('colorscheme nvimgelion')
-- vim.cmd('colorscheme citruszest')
-- vim.cmd('colorscheme retrobox')
-- vim.cmd('colorscheme elrond')
-- vim.cmd('colorscheme pop-punk')
-- vim.cmd('colorscheme eldar')
-- vim.cmd('colorscheme vividchalk')

-- =========== Autogroup ===========

-- vim.api.nvim_create_augroup('MARLRUS', { clear = true })
-- vim.api.nvim_create_autocmd('BufWritePre', {
--   group = 'MARLRUS',
--   pattern = '*',
--   command = 'Neoformat',
-- })

-- =========== Remaps ===========

local map = vim.keymap.set

-- Window navigation
map('n', '<leader>h', ':wincmd h<CR>')
map('n', '<leader>j', ':wincmd j<CR>')
map('n', '<leader>l', ':wincmd l<CR>')
map('n', '<leader>k', ':wincmd k<CR>')

-- FZF / Search
map('n', '<leader>ps', ':Rg<CR>')
map('n', '<leader>pp', ':GFiles<CR>')
map('n', '<leader>pf', ':Files<CR>')
map('n', '<leader>pb', ':Buffers<CR>')

-- Floaterm
map('n', '<leader>pv', ':FloatermNew --height=0.9 ranger<CR>')
map('n', '<leader>pt', ':FloatermNew<CR>')
map('n', '<leader>pc', ':FloatermNew --cwd %:h<CR>')

-- Git
map('n', '<leader>gv', ':FloatermNew lazygit<CR>')
map('n', '<leader>gb', ':Git blame<CR>')
map('n', '<leader>gs', ':G<CR>')
map('n', '<leader>gh', ':diffget //3<CR>')
map('n', '<leader>gu', ':diffget //2<CR>')

-- GitGutter
map('n', '<leader>gc', '<Plug>(GitGutterPreviewHunk)')
map('n', '<leader>gn', '<Plug>(GitGutterNextHunk)')
map('n', '<leader>gN', '<Plug>(GitGutterPrevHunk)')
map('n', '<leader>gu', '<Plug>(GitGutterUndoHunk)')

-- Undotree
map('n', '<leader>pu', ':UndotreeToggle<CR>')

-- Move line up/down
map('n', '<A-j>', ':m .+1<CR>==')
map('n', '<A-k>', ':m .-2<CR>==')

-- WhichKey
map('n', '<leader>', ':WhichKey \'<Space>\'<CR>', { silent = true })

-- Spell check
map('n', '<leader>es', ':set spell spelllang=es<CR>')
map('n', '<leader>en', ':set spell spelllang=en<CR>')
map('n', '<leader>ee', ':set spell spelllang=en,es<CR>')
map('n', '<leader>eu', ':set nospell<CR>')
map('n', '<leader>s', ']s')
map('n', '<leader>S', '[s')
map('n', '<leader>z', 'z=')

-- Format
map('n', '<leader>f', ':Neoformat<CR>')
map('x', '<leader>f', ':Neoformat<CR>')

-- LSP diagnostics
map('n', '<leader>n', vim.diagnostic.goto_next)
map('n', '<leader>N', vim.diagnostic.goto_prev)

-- Debugger
map('n', '<leader>db', function() require('dap').toggle_breakpoint() end)
map('n', '<leader>dc', function() require('dap').continue() end)
map('n', '<leader>dt', function() require('dap').terminate() end)
map('n', '<leader>dso', function() require('dap').step_over() end)
map('n', '<leader>dsi', function() require('dap').step_into() end)

-- Macro on visual range
map('x', '@', ':<C-u>call ExecuteMacroOverVisualRange()<CR>')

vim.cmd([[
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
]])

-- =========== Plugin Settings ===========

-- Floaterm
vim.g.floaterm_width = 0.9
vim.g.floaterm_height = 0.9
vim.g.floaterm_autoclose = 1
vim.g.floaterm_opener = 'edit'

-- Ripgrep
if vim.fn.executable('rg') == 1 then
  vim.g.rg_derive_root = 'true'
  -- vim.g.rg_command = 'rg --hidden'
end

-- GitGutter
vim.g.gitgutter_map_keys = 0
vim.g.gitgutter_preview_win_floating = 1
vim.cmd('highlight! link SignColumn LineNr')

-- =========== Nvim CMP ===========

local cmp = require('cmp')

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
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    -- { name = 'luasnip' },
    -- { name = 'ultisnips' },
    -- { name = 'snippy' },
  }, {
    { name = 'buffer' },
  })
})

-- To use git you need to install petertriho/cmp-git and uncomment:
--[[ cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})
require("cmp_git").setup() ]]

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- =========== LSP ===========

-- Dynamically find and inject the active NVM directory into Neovim's runtime path
local nvm_dir = os.getenv("HOME") .. "/.nvm/versions/node/"
local handle = io.popen("ls " .. nvm_dir .. " 2>/dev/null")
if handle then
  local result = handle:read("*a")
  handle:close()
  local versions = {}
  for version in string.gmatch(result, "[^\r\n]+") do
    table.insert(versions, version)
  end
  if #versions > 0 then
    local active_node_bin = nvm_dir .. versions[#versions] .. "/bin"
    vim.env.PATH = active_node_bin .. ":" .. vim.env.PATH
  end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(_, bufnr)
  vim.keymap.set('n', 'gD',       vim.lsp.buf.declaration,    { buffer = bufnr })
  vim.keymap.set('n', 'gd',       vim.lsp.buf.definition,     { buffer = bufnr })
  vim.keymap.set('n', 'gr',       vim.lsp.buf.references,     { buffer = bufnr })
  vim.keymap.set('n', 'gi',       vim.lsp.buf.implementation, { buffer = bufnr })
  vim.keymap.set('n', 'K',        vim.lsp.buf.hover,          { buffer = bufnr })
  vim.keymap.set('n', 'gy',       vim.lsp.buf.type_definition,{ buffer = bufnr })
  vim.keymap.set('n', '<F2>',     vim.lsp.buf.rename,         { buffer = bufnr })
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float,  { buffer = bufnr })
end

local server_configs = {
  ts_ls = {
    cmd          = { 'typescript-language-server', '--stdio' },
    filetypes    = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
    root_markers = { 'tsconfig.json', 'package.json', '.git' },
  },
  jsonls = {
    cmd          = { 'vscode-json-language-server', '--stdio' },
    filetypes    = { 'json', 'jsonc' },
    root_markers = { 'package.json', '.git' },
  },
  cssls = {
    cmd          = { 'vscode-css-language-server', '--stdio' },
    filetypes    = { 'css', 'scss', 'less' },
    root_markers = { 'package.json', '.git' },
  },
  graphql = {
    cmd          = { 'graphql-lsp', 'server', '-m', 'stream' },
    filetypes    = { 'graphql' },
    root_markers = { '.graphqlrc', 'graphql.config.js', 'package.json', '.git' },
  },
  yamlls = {
    cmd          = { 'yaml-language-server', '--stdio' },
    filetypes    = { 'yaml', 'yaml.docker-compose' },
    root_markers = { '.git' },
  },
  bashls = {
    cmd          = { 'bash-language-server', 'start' },
    filetypes    = { 'sh', 'bash' },
    root_markers = { '.git' },
  },
  vimls = {
    cmd          = { 'vim-language-server', '--stdio' },
    filetypes    = { 'vim' },
    root_markers = { '.git' },
  },
  html = {
    cmd          = { 'vscode-html-language-server', '--stdio' },
    filetypes    = { 'html' },
    root_markers = { 'package.json', '.git' },
  },
  docker_compose_language_service = {
    cmd          = { 'docker-compose-langserver', '--stdio' },
    filetypes    = { 'yaml.docker-compose' },
    root_markers = { 'docker-compose.yml', 'docker-compose.yaml', '.git' },
  },
  dockerls = {
    cmd          = { 'docker-langserver', '--stdio' },
    filetypes    = { 'dockerfile' },
    root_markers = { 'Dockerfile', '.git' },
  },
  nxls = {
    cmd          = { 'nxls', '--stdio' },
    filetypes    = { 'json', 'jsonc' },
    root_markers = { 'nx.json', 'package.json', '.git' },
  },
}

-- Register configs and enable servers
for server, config in pairs(server_configs) do
  vim.lsp.config(server, {
    cmd          = config.cmd,
    filetypes    = config.filetypes,
    capabilities = capabilities,
    on_attach    = on_attach,
  })
  -- vim.lsp.enable(server)
end

-- Auto-start servers on FileType with root_dir resolved per file
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'typescript', 'javascript', 'typescriptreact', 'javascriptreact',
    'json', 'jsonc', 'css', 'scss', 'less', 'graphql',
    'yaml', 'sh', 'bash', 'vim', 'html', 'dockerfile',
  },
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local fname = vim.api.nvim_buf_get_name(args.buf)

    for server, config in pairs(server_configs) do
      if vim.tbl_contains(config.filetypes, ft) then
        local root = vim.fs.dirname(
          vim.fs.find(config.root_markers, { path = fname, upward = true })[1]
        ) or vim.fn.getcwd()

        vim.lsp.start({
          name         = server,
          cmd          = config.cmd,
          filetypes    = config.filetypes,
          capabilities = capabilities,
          on_attach    = on_attach,
          root_dir     = root,
        })
      end
    end
  end,
})

vim.diagnostic.config({
  underline        = true,
  signs            = true,
  update_in_insert = true,
})

-- =========== Debugger (DAP) ===========

local dap, dapui = require('dap'), require('dapui')

dapui.setup()

dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

for _, language in ipairs({ 'typescript', 'javascript' }) do
  dap.configurations[language] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      cwd = '${workspaceFolder}',
    },
    {
      type = 'pwa-node',
      request = 'attach',
      address = 'localhost',
      name = 'Auto Attach To Localhost Default',
      cwd = '${workspaceFolder}',
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach to Process',
      processId = require('dap.utils').pick_process,
      cwd = '${workspaceFolder}',
    },
  }
end

require('dap-vscode-js').setup({
  -- node_path = 'node',
  debugger_path = '/home/marlrus/.dotfiles/vscode-js-debug',
  -- debugger_cmd = { 'js-debug-adapter' },
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
  -- log_file_path = '(stdpath cache)/dap_vscode_js.log'
  -- log_file_level = false
  -- log_console_level = vim.log.levels.ERROR
})
