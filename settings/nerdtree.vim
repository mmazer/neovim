let NERDChristmasTree=1
let NERDTreeWinSize=35
let NERDTreeDirArrows=1
let NERDTreeIgnore=['\.pyc$']

noremap <space>nb :NERDTreeFromBookmark<SPACE>
noremap <space>nc :NERDTreeCWD<CR>
noremap <space>nf :NERDTreeFind<CR>
noremap <silent> gon :NERDTreeToggle<CR>
noremap <space>no :NERDTree %:p:h<CR>
