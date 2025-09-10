vim.o.mouse = ''
vim.opt.clipboard = 'unnamedplus'

vim.keymap.set('n', '<leader>h', ':wincmd h<CR>', { noremap = true })
vim.keymap.set('n', '<leader>h', ':wincmd h<CR>', { noremap = true })
vim.keymap.set('n', '<leader>j', ':wincmd j<CR>', { noremap = true })
vim.keymap.set('n', '<leader>l', ':wincmd l<CR>', { noremap = true })
vim.keymap.set('n', '<leader>k', ':wincmd k<CR>', { noremap = true })

vim.keymap.set('n',' <leader>ps', ':Rg<CR>', { noremap = true })
vim.keymap.set('n', '<leader>pv', ':FloatermNew --height=0.9 ranger<cr>', { noremap = true })
vim.keymap.set('n', '<leader>pp', ':GFiles<CR>', { noremap = true })
vim.keymap.set('n', '<leader>pf', ':Files<CR>', { noremap = true })
vim.keymap.set('n', '<leader>pb', ':Buffers<CR>', { noremap = true })

-- Floaterm Related
vim.keymap.set('n', '<leader>pt', ':FloatermNew<CR>', { noremap = true })
vim.keymap.set('n', '<leader>pc', ':FloatermNew --cwd %:h<CR>', { noremap = true })

-- Git Related
vim.keymap.set('n', '<leader>gv', ':FloatermNew lazygit<CR>', { noremap = true })
 
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { noremap = true })
vim.keymap.set('n', '<leader>pu', ':UndotreeToggle<CR>', { noremap = true })

vim.keymap.set('n', '<leader>gs', ':G<CR>', { noremap = true })
vim.keymap.set('n', '<leader>gh', ':diffget //3<CR>', { noremap = true })
vim.keymap.set('n', '<leader>gu', ':diffget //2<CR>', { noremap = true })

vim.keymap.set('n', '<leader>gc', '<Plug>(GitGutterPreviewHunk)', { remap = true })
vim.keymap.set('n', '<leader>gn', '<Plug>(GitGutterNextHunk)', { remap = true })
vim.keymap.set('n', '<leader>gN', '<Plug>(GitGutterPrevHunk)', { remap = true })
vim.keymap.set('n', '<leader>gu', '<Plug>(GitGutterUndoHunk)', { remap = true })

 -- move line up/down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { noremap = true })
vim.keymap.set('n', '<A-k>', ':mj.-2<CR>==', { noremap = true })

 -- WhichKey
vim.keymap.set('n', '<silent> <leader>', ':WhichKey <Space><CR>', { noremap = true })

 -- Spell Check related
vim.keymap.set('n', '<leader>es', ':set spell spelllang=es<CR>', { noremap = true })
vim.keymap.set('n', '<leader>en', ':set spell spelllang=en<CR>', { noremap = true })
vim.keymap.set('n', '<leader>ee', ':set spell spelllang=en,es<CR>', { noremap = true })
vim.keymap.set('n', '<leader>eu', ':set nospell<CR>', { noremap = true })
vim.keymap.set('n', '<leader>s', ']s', { noremap = true })
vim.keymap.set('n', '<leader>S', '[s', { noremap = true })
vim.keymap.set('n', '<leader>z', 'z=', { noremap = true })

 -- LSP diagnostics Keybinds
vim.keymap.set('n', '<leader>n', ':lua vim.diagnostic.goto_next()<CR>', { remap = true })
vim.keymap.set('n', '<leader>N', ':lua vim.diagnostic.goto_prev()<CR>', { remap = true })
 
vim.keymap.set('n', '<leader>f', ':Neoformat<CR>', { noremap = true })
vim.keymap.set('x', '<leader>f', ':Neoformat<CR>', { noremap = true })
