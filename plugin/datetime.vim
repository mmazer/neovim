function! DateTimeStamp()
    return strftime("%Y-%m-%d %H:%M")
endfun

function! ShortDate()
    return strftime("%Y-%m-%d")
endfun

function! ShowTime()
    echo strftime('%a %d %b %H:%M:%S Week %W')
endfunction
command! Date :call ShowTime()

function! Calendar(month)
    let cmd = '!cal'
    if a:month || a:month != ''
        let cmd = cmd . ' -m ' . a:month
    endif
    12new
    :file Calendar
    :put =strftime('Today is %c Week %W')
    :normal o
    :silent exec 'r ' . cmd
    :normal gg
    setlocal bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction
command! -nargs=? Cal :call Calendar('<args>')
nnoremap goc :Cal<CR>

iab dts <c-r>=DateTimeStamp()<esc>
iab ddt <c-r>=ShortDate()<esc>
