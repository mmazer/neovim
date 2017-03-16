if exists("g:loaded_openuri")
  finish
endif

let g:loaded_openuri = 1

noremap gou :call openuri#inline()<CR>
