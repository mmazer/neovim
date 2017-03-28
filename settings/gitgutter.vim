let g:gitgutter_enabled = 0
let g:gitgutter_diff_args = '-w'
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '='
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_modified_removed = '~'

nnoremap [og :GitGutterEnable<CR>
nnoremap ]og :GitGutterDisable<CR>
nnoremap cog :GitGutterToggle<CR>
nnoremap ]gg :GitGutterNextHunk<CR>zz
nnoremap [gg :GitGutterPrevHun<CR>zz
nnoremap ]gv :GitGutterPreviewHunk<CR>
nnoremap [gh :GitGutterStageHunk<CR>
nnoremap ]gh :GitGutterUndoHunk<CR>
nnoremap ]gp  :GitGutterPreviewHunk<CR>
