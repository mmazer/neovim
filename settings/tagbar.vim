let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Headings'
    \ ]
\ }

nnoremap <silent> got :TagbarCurrentTag<CR>
