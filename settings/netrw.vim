let g:netrw_banner=0
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+,\(^\|\s\s\)ntuser\.\S\+'
let g:netrw_winsize = 20
let g:netrw_browse_split = 4

nnoremap - :Explore<CR>
nnoremap _ :Vexplore<CR>
augroup Netrw
  autocmd!
  autocmd FileType netrw nnoremap q :bd!<CR>
augroup END

