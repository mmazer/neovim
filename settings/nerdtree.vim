let NERDChristmasTree=1
let NERDTreeWinSize=35
let NERDTreeDirArrows=1
let NERDTreeIgnore=['\.pyc$']
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1

nnoremap <silent> <space>nc :NERDTreeCWD<CR>
nnoremap <silent> <space>nr :exe 'NERDTree '.vutils#root_dir()<CR>
nnoremap <silent> <space>nf :NERDTreeFind<CR>
nnoremap <silent> cot       :NERDTreeToggle<CR>
nnoremap <silent> -         :NERDTree %:p:h<CR>
