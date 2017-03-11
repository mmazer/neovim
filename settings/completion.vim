set completeopt=longest,menuone,preview
set omnifunc=syntaxcomplete#Complete

if has("gui_running") || has("gui_vimr")
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <C-@> <C-x><C-o>
endif

inoremap <C-f> <C-x><C-f>
inoremap <C-p> <C-x><C-p>
