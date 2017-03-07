let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Headings'
    \ ]
\ }

nnoremap cot :TagbarToggle<CR>
nnoremap <silent> got :TagbarCurrentTag<CR>
