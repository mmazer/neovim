set foldmethod=syntax                   "fold based on indent
set foldnestmax=2                       "deepest fold is 10 levels
set nofoldenable                        "don't fold by default
let g:xml_syntax_folding=1              "enable xml folding

nnoremap <Space>z za
vnoremap <Space>z za

" refocus fold under cursor - from Steve Losh
nnoremap ,z zMzvzz

set foldtext=ufold#fold_text()

" toggling following vim-unimpaired
nnoremap [of :setlocal foldcolumn=3<CR>
nnoremap ]of :setlocal foldcolumn=0<CR>
