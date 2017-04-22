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

function! UpdateModifiedTimestamp()
    let lines = line('$')
    if lines < 10
        return
    endif

    try
        :1,10s/^\<[Mm]odified\>\:\s\zs.*/\=datetime#timestamp()/ge
    catch
    endtry
endfunction

autocmd BufWritePre *.md call vutils#preserve_wrapper(function('UpdateModifiedTimestamp'))
