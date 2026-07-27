-- =========== Lazy.nvim Bootstrap ===========
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

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

-- Neoformat: use project-local binaries (node_modules/.bin) before global
vim.g.neoformat_try_node_exe = 1

-- Block blinking cursor
vim.o.guicursor = 'n-v-c-i:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'

-- vim.o.ls = 0
-- vim.o.ch = 0
-- vim.o.colorcolumn = '100'

-- =========== Plugins ===========

require('lazy').setup({
  -- ---- Fuzzy Finding ----
  { 'ibhagwan/fzf-lua' },
  { 'junegunn/fzf', build = function() vim.fn['fzf#install']() end },

  -- ---- Terminal ----
  { 'akinsho/toggleterm.nvim' },

  -- ---- Which Key ----
  { 'folke/which-key.nvim' },

  -- ---- Formatting ----
  { 'sbdchd/neoformat' },

  -- ---- Editing Utilities ----
  { 'windwp/nvim-autopairs' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'echasnovski/mini.comment' },

  -- ---- Git ----
  { 'tpope/vim-fugitive' },
  { 'lewis6991/gitsigns.nvim' },

  -- ---- Colorschemes ----
  { 'tpope/vim-vividchalk' },
  { 'bignimbus/pop-punk.vim' },
  { 'zootedb0t/citruszest.nvim' },
  { 'nyngwang/nvimgelion' },
  { 'aperezdc/vim-elrond' },
  { 'balanceiskey/vim-framer-syntax' },
  { 'bluz71/vim-moonfly-colors' },
  { 'agude/vim-eldar' },

  -- ---- Misc ----
  { 'styled-components/vim-styled-components', branch = 'main' },
  { 'mbbill/undotree' },

  -- ---- Debugger ----
  { 'mfussenegger/nvim-dap' },
  { 'rcarriga/nvim-dap-ui' },
  { 'nvim-neotest/nvim-nio' },

  -- ---- Completion ----
  { 'saghen/blink.cmp', version = '1.*' },

}, {
  install = {
    colorscheme = { 'nvimgelion' },
  },
  ui = {
    border = 'rounded',
  },
})

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

-- =========== Toggleterm Terminals ===========

local Terminal = require('toggleterm.terminal').Terminal

-- Float size — change this value to resize all terminals at once
local float_scale = 0.80
local function make_float_opts()
  return {
    width  = math.floor(vim.o.columns * float_scale),
    height = math.floor(vim.o.lines * float_scale),
  }
end

-- Ranger
local cache_dir = vim.fn.stdpath('cache')
if vim.fn.isdirectory(cache_dir) == 0 then vim.fn.mkdir(cache_dir, 'p') end
local ranger_chooser_path = cache_dir .. '/ranger_chooser'

function _RANGER_TOGGLE()
  pcall(vim.fn.delete, ranger_chooser_path)
  local t = Terminal:new({
    cmd        = 'ranger --choosefile=' .. ranger_chooser_path,
    hidden     = true,
    direction  = 'float',
    float_opts = make_float_opts(),
    dir        = vim.fn.expand('%:h'),
    on_close   = function(_)
      if vim.fn.filereadable(ranger_chooser_path) == 1 then
        local lines = vim.fn.readfile(ranger_chooser_path)
        pcall(vim.fn.delete, ranger_chooser_path)
        if #lines > 0 and lines[1] ~= '' then
          vim.schedule(function()
            vim.cmd('edit ' .. vim.fn.fnameescape(lines[1]))
          end)
        end
      end
    end,
  })
  t:toggle()
end

function _LAZYGIT_TOGGLE()
  local t = Terminal:new({
    cmd        = 'lazygit',
    hidden     = true,
    direction  = 'float',
    float_opts = make_float_opts(),
  })
  t:toggle()
end

function _CWD_TOGGLE()
  local t = Terminal:new({
    dir        = vim.fn.expand('%:h'),
    direction  = 'float',
    float_opts = make_float_opts(),
  })
  t:toggle()
end

map('n', '<leader>pv', function() _RANGER_TOGGLE() end)
map('n', '<leader>pt', ':ToggleTerm<CR>')
map('n', '<leader>pc', function() _CWD_TOGGLE() end)
map('n', '<leader>gv', function() _LAZYGIT_TOGGLE() end)

-- =========== FZF-Lua ===========

local fzf_float_scale = 0.75

require('fzf-lua').setup({
  winopts = {
    height = fzf_float_scale,
    width  = fzf_float_scale,
  },
})

map('n', '<leader>ps', ':FzfLua live_grep<CR>')
map('n', '<leader>pp', ':FzfLua git_files<CR>')
map('n', '<leader>pf', ':FzfLua files<CR>')
map('n', '<leader>pF', function() require('fzf-lua').files({ cwd = vim.fn.expand('%:h') }) end)
map('n', '<leader>pb', ':FzfLua buffers<CR>')

-- Git (fugitive)
map('n', '<leader>gb', ':Git blame<CR>')
map('n', '<leader>gs', ':G<CR>')
map('n', '<leader>gh', ':diffget //3<CR>')
map('n', '<leader>gu', ':diffget //2<CR>')

-- Gitsigns
map('n', '<leader>gc', ':Gitsigns preview_hunk<CR>')
map('n', '<leader>gn', ':Gitsigns next_hunk<CR>')
map('n', '<leader>gN', ':Gitsigns prev_hunk<CR>')
map('n', '<leader>gU', ':Gitsigns reset_hunk<CR>')
map('n', '<leader>gl', ':Gitsigns blame_line<CR>')

-- Undotree
map('n', '<leader>pu', ':UndotreeToggle<CR>')

-- Move line up/down
map('n', '<A-j>', ':m .+1<CR>==')
map('n', '<A-k>', ':m .-2<CR>==')

-- WhichKey
map('n', '<leader>', function() require('which-key').show({ keys = '<leader>' }) end, { silent = true })

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
vim.diagnostic.config({
  underline        = true,
  signs            = true,
  update_in_insert = true,
  virtual_text     = true,
  float            = {
    border   = 'rounded',
    source   = true,
    focusable = false,
  },
})

-- LSP diagnostics
map('n', '<leader>n', function() vim.diagnostic.jump({ count = 1 }) end)
map('n', '<leader>N', function() vim.diagnostic.jump({ count = -1 }) end)
map('n', '<leader>e', function() vim.diagnostic.open_float() end)

-- Debugger
map('n', '<leader>db',  function() require('dap').toggle_breakpoint() end)
-- Set or remove a breakpoint on the current line

map('n', '<leader>dB',  function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
-- Set a conditional breakpoint — only pauses when the condition is true (e.g. userId === '123')

map('n', '<leader>dl',  function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
-- Set a log point — prints a message to the console without pausing execution

map('n', '<leader>dc',  function() require('dap').continue() end)
-- Start the session or continue execution until the next breakpoint

map('n', '<leader>dt',  function() require('dap').terminate() end)
-- Terminate the debug session

map('n', '<leader>dso', function() require('dap').step_over() end)
-- Step over — execute the current line and move to the next, without entering function calls

map('n', '<leader>dsi', function() require('dap').step_into() end)
-- Step into — enter the function call on the current line to debug inside it

map('n', '<leader>dsu', function() require('dap').step_out() end)
-- Step out — finish executing the current function and pause back at the caller

map('n', '<leader>drc', function() require('dap').run_to_cursor() end)
-- Run to cursor — continue execution and pause at the line the cursor is on

map('n', '<leader>du',  function() require('dapui').toggle() end)
-- Toggle the DAP UI panels (scopes, stacks, watches, console)

map('n', '<leader>de',  function() require('dapui').eval() end)
-- Evaluate the expression under the cursor and show its current value

map('v', '<leader>de',  function() require('dapui').eval() end)
-- Evaluate the highlighted expression and show its current value

-- Macro on visual range
map('x', '@', ':<C-u>call ExecuteMacroOverVisualRange()<CR>')

vim.cmd([[
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
]])

-- =========== Plugin Settings ===========

-- Ripgrep
if vim.fn.executable('rg') == 1 then
  vim.g.rg_derive_root = 'true'
end

-- =========== Toggleterm ===========

require('toggleterm').setup({
  size      = 20,
  direction = 'float',
  float_opts = {
    border = 'curved',
    width  = math.floor(vim.o.columns * 0.9),
    height = math.floor(vim.o.lines * 0.9),
  },
  close_on_exit = true,
  shell         = vim.o.shell,
})

-- =========== Which-Key ===========

require('which-key').setup({})

-- =========== Nvim Autopairs ===========

require('nvim-autopairs').setup({})

-- =========== Treesitter ===========

require('nvim-treesitter.config').setup({
  ensure_installed = {
    'typescript', 'javascript', 'tsx', 'json',
    'css', 'html', 'yaml', 'bash', 'lua', 'dockerfile',
  },
  auto_install = true,
  highlight = { enable = true },
})

-- =========== ts-context-commentstring ===========

require('ts_context_commentstring').setup({
  enable_autocmd = false,
})

-- =========== mini.comment ===========

require('mini.comment').setup({
  options = {
    custom_commentstring = function()
      return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
    end,
  },
})

-- =========== Gitsigns ===========

require('gitsigns').setup({
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
  },
  preview_config = {
    border = 'rounded',
  },
})

vim.cmd('highlight! link SignColumn LineNr')

-- =========== Blink CMP ===========

require('blink.cmp').setup({
  keymap = {
    preset = 'default',
    ['<C-e>'] = { 'cancel', 'fallback' },
    ['<Tab>'] = { 'accept', 'fallback' },
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
  },
  sources = {
    default = { 'lsp', 'buffer', 'path', 'cmdline' },
  },
  completion = {
    documentation = { auto_show = true },
  },
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

local capabilities = require('blink.cmp').get_lsp_capabilities()

local on_attach = function(_, bufnr)
  vim.keymap.set('n', 'gD',       vim.lsp.buf.declaration,    { buffer = bufnr })
  vim.keymap.set('n', 'gd',       vim.lsp.buf.definition,     { buffer = bufnr })
  vim.keymap.set('n', 'gr',       vim.lsp.buf.references,     { buffer = bufnr })
  vim.keymap.set('n', 'gi',       vim.lsp.buf.implementation, { buffer = bufnr })
  vim.keymap.set('n', 'K',        vim.lsp.buf.hover,          { buffer = bufnr })
  vim.keymap.set('n', 'gy',       vim.lsp.buf.type_definition,{ buffer = bufnr })
  vim.keymap.set('n', '<F2>',     vim.lsp.buf.rename,         { buffer = bufnr })
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

-- Register configs without enabling — autocommand handles startup
for server, config in pairs(server_configs) do
  vim.lsp.config(server, {
    cmd          = config.cmd,
    filetypes    = config.filetypes,
    capabilities = capabilities,
    on_attach    = on_attach,
  })
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

local debugger_path = '/home/marlrus/.dotfiles/vscode-js-debug/dist/src/dapDebugServer.js'

for _, adapter in ipairs({ 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }) do
  dap.adapters[adapter] = {
    type = 'server',
    host = '127.0.0.1',
    port = '${port}',
    executable = {
      command = 'node',
      args    = { debugger_path, '${port}' },
    },
  }
end

for _, language in ipairs({ 'typescript', 'javascript' }) do
  dap.configurations[language] = {
    {
      type    = 'pwa-node',
      request = 'launch',
      name    = 'Launch file',
      program = '${file}',
      cwd     = '${workspaceFolder}',
    },
    {
      type    = 'pwa-node',
      request = 'attach',
      address = 'localhost',
      name    = 'Auto Attach To Localhost Default',
      cwd     = '${workspaceFolder}',
    },
    {
      type      = 'pwa-node',
      request   = 'attach',
      name      = 'Attach to Process',
      processId = require('dap.utils').pick_process,
      cwd       = '${workspaceFolder}',
    },
    {
      type       = 'pwa-node',
      request    = 'attach',
      name       = 'Attach to Docker',
      address    = 'localhost',
      port       = 9229,
      cwd        = '${workspaceFolder}',
      localRoot  = '${workspaceFolder}',
      remoteRoot = '/app',
      sourceMaps = true,
      outFiles   = {
        '${workspaceFolder}/dist/**/*.js',
        '!${workspaceFolder}/node_modules/**',
      },
      skipFiles  = { '<node_internals>/**', 'node_modules/**' },
      resolveSourceMapLocations = {
        '${workspaceFolder}/**',
        '!**/node_modules/**',
      },
      pauseForSourceMap = false,
      timeout    = 30000,
      sourceMapPathOverrides = {
        ['/app/src/*'] = '${workspaceFolder}/src/*',
        ['/app/*']     = '${workspaceFolder}/*',
      },
    },
  }
end
