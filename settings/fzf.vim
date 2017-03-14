let g:fzf_tags_command = 'ctags --extra=+f -R'

nmap <space> [fzf]
nnoremap <silent> [fzf]a :Ag<CR>
nnoremap <silent> [fzf]b :Buffers<cr>
nnoremap <silent> [fzf]c :BCommits<CR>
nnoremap <silent> [fzf]C :Commits<CR>
nnoremap <silent> [fzf]f :Files<CR>
nnoremap <silent> [fzf]g :GitFiles<CR>
nnoremap <silent> [fzf]h :History:<CR>
nnoremap <silent> [fzf]/ :History/<CR>
nnoremap <silent> [fzf]l :BLines<CR>
nnoremap <silent> [fzf]L :Lines<CR>
nnoremap <silent> [fzf]m :Marks<CR>
nnoremap <silent> [fzf]r :History<CR>
nnoremap <silent> [fzf]s :Snippets<CR>
nnoremap <silent> [fzf]t :BTags<cr>
nnoremap <silent> [fzf]T :Tags<CR>
