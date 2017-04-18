if exists("g:autoloaded_datetime")
  finish
endif
let g:autoloaded_datetime = 1

if !exists('g:timestamp_format')
    let g:timestamp_format = '%Y-%m-%dT%H:%M:%S %Z'
endif

function! datetime#timestamp()
    return strftime(g:timestamp_format)
endfun

function! datetime#datetime()
    return strftime("%Y-%m-%d %H:%M")
endfun

function! datetime#short_date()
    return strftime("%Y-%m-%d")
endfun

function! datetime#date()
    echo strftime('%a %d %b %H:%M:%S Week %W')
endfunction
command! Date :call ShowTime()

function! datetime#cal(month)
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
