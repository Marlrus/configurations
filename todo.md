# Todo list

## Remaining

- Split nvim configurations
- Checkout undotree
- Create bash script that listens to changes on these files
- Debugging in vim?

## WIP

## Completed

- vim-commentary
- Inline git changes without coc
- replace coc-vim with vim-gitgutter
- nvim-lsp
- configure lsp diagnostics
- Autocomplete with tab
- nvim-deoplete + lsp (winner)
- snippets with neosnippet.vim
- vim airline git branch or lightline to avoid vim fugitive (added vim fugitive)

## Notes

### deoplete and neosnippet.vim

This plugin can come with default pluggins and integrates with deoplete. I could not select the snippets at first and had to remap to select and move between parts of a snippet. I created custom snippets, they need to follow the format **filetype.snip** in order to be detected. To set them as a top priority I had to call a deoplete fn. All in all, I am extremely satisfied with my setup for autocompletion.

```vim
" Completion menu settings and strategy
" Use depolete.
let g:deoplete#enable_at_startup = 1
" set priority in selection
call deoplete#custom#source('neosnippet', 'rank', 1000)
set completeopt=menu,noselect,noinsert
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" let g:completion_confirm_key = "\<C-Space>"
" Move through snippets using tab
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" disable default snippets from neosnippets
let g:neosnippet#disable_runtime_snippets = {'_' : 1}
let g:neosnippet#snippets_directory = '~/.config/nvim/snippets'
" select snippets and move between points in snippet
imap <c-s>     <Plug>(neosnippet_expand_or_jump)
smap <c-s>     <Plug>(neosnippet_expand_or_jump)
xmap <c-s>     <Plug>(neosnippet_expand_target)
```
