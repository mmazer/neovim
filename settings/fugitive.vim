nnoremap <space>gs :Gstatus<CR>
nnoremap <space>gb :Gblame<CR>
nnoremap <space>gc :Gcommit -v -q <CR>
nnoremap <space>gd :Gdiff<CR>
nnoremap <space>ge :Gedit<CR>
nnoremap <space>gl :Glog<CR>
nnoremap <space>gr :Gread<CR>
nnoremap <space>gw :Gwrite<CR>
nnoremap <space>gp :Ggrep<CR>

" Simple way to turn off Gdiff splitscreen
" works only when diff buffer is focused
" https://gist.github.com/radmen/5048080
command! Gdoff diffoff | q | Gedit

command! Glast :Glog -n 8 --

augroup Fugitive
    autocmd!
    autocmd BufRead fugitive\:* xnoremap <buffer> dp :diffput<CR>|xnoremap <buffer> do :diffget<CR>
    autocmd FilterWritePre * if &diff | nnoremap <buffer> dc :Gdoff<CR> | nnoremap <buffer> du :diffupdate<CR> | endif
    autocmd BufNewFile,BufRead fugitive://* set bufhidden=delete
augroup END
