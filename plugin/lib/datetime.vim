function! DateTimeStamp()
    return strftime("%Y-%m-%d %H:%M")
endfun

function! ShortDate()
    return strftime("%Y-%m-%d")
endfun

function! ShowTime()
    echo strftime('%a %d %b %H:%M:%S')
endfunction
nnoremap got :call ShowTime()<CR>
