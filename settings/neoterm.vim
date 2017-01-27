" use half of current window for neoterm
let g:neoterm_size=''
nnoremap <silent> tv :Tpos vertical<CR>
nnoremap <silent> th :Tpos horizontal<CR>
nnoremap <silent> tn :Tnew<CR>
nnoremap <silent> to :Topen<CR>
nnoremap <silent> tc :Tclose<CR>
nnoremap <silent> tl :TREPLSendLine<CR>
vnoremap <silent> tl :TREPLSendSelection<CR>
nnoremap tt :T<space>

" general terminal bindings
tnoremap <C-x> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
