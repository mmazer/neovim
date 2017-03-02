augroup Dirvish
    autocmd!
    autocmd FileType dirvish call fugitive#detect(@%)
    autocmd FileType dirvish nnoremap <silent><buffer> gr :<C-U>Dirvish %<CR>
     autocmd FileType dirvish nnoremap <silent><buffer>
        \ gh :silent keeppatterns g@\v/\.[^\/]+/?$@d<cr>
augroup END
