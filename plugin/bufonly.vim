" BufOnly.vim  -  Delete all the buffers except the current/named buffer.
"
" Copyright November 2003 by Christian J. Robinson <infynity@onewest.net>
"
" Distributed under the terms of the Vim license.  See ":help license".
"
" Usage:
"
" :Bonly [buffer]
"
" Without any arguments the current buffer is kept.  With an argument the
" buffer name/number supplied is kept.

" http://www.vim.org/scripts/script.php?script_id=1071

if exists("g:loaded_bufonly")
  finish
endif
let g:loaded_bufonly = 1

command! -nargs=? -complete=buffer -bang Bonly
            \ :call bufonly#bufonly('<args>', '<bang>')

