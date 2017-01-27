let g:fzf_tags_command = 'ctags --extra=+f -R'

nmap <space> [fzf]
nnoremap <silent> [fzf]a :Ag<CR>
nnoremap <silent> [fzf]b :Buffers<cr>
nnoremap <silent> [fzf]c :History:<CR>
nnoremap <silent> [fzf]C :BCommits<CR>
nnoremap <silent> [fzf]f :Files<CR>
nnoremap <silent> [fzf]g :GitFiles<CR>
nnoremap <silent> [fzf]l :Lines<CR>
nnoremap <silent> [fzf]m :Marks<CR>
nnoremap <silent> [fzf]s :BLines<CR>
nnoremap <silent> [fzf]t :BTags<cr>
nnoremap <silent> [fzf]T :Tags<CR>
nnoremap <silent> [fzf]u :History<CR>
