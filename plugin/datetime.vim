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

function! Calendar()
    new
    :put =strftime('%c')
    :normal o
    :silent exec 'r !cal'
    :normal gg
    setlocal bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction
command! Cal :call Calendar()
nnoremap goc :Cal<CR>

iab dts <c-r>=DateTimeStamp()<esc>
iab ddt <c-r>=ShortDate()<esc>
