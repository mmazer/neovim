setlocal sw=2
setlocal sts=2
setlocal suffixesadd=.txt,.md

function! PreviewMarkdown()
    if executable("marked")
        exec ":silent !marked \"%\""
    else
        echo "Marked application not found"
    endif
endfunction
map <buffer> <leader>p :call PreviewMarkdown()<CR>
command! Marked :call PreviewMarkdown()

function! s:update_modified_timestamp()
    silent :1,20s/^\<[Mm]odified\>\:\s\zs.*/\=datetime#timestamp()/ge
endfunction

autocmd BufWritePost *.md call vutils#preserve_wrapper(function('s:update_modified_timestamp'))
