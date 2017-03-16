if exists('g:autoloaded_gitter')
  finish
endif
let g:autoloaded_gitter = 1

function! gitter#diff_buff()
    let fname = expand('%')
    new
    exec "r! git diff ".printf('%s', fname)
    :normal ggdd
    setlocal ft=diff bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction

function! gitter#diff_staged()
    new
    r !git diff -w --cached
    :normal ggdd
    setlocal ft=diff bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction

function! gitter#diff_unstaged()
    new
    r !git diff -w
    :normal ggdd
    setlocal ft=diff bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction

function! gitter#incoming()
    new
    r !git log --pretty=oneline --abbrev-commit --graph ..@{u}
    setlocal ft=git bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction

function! gitter#outgoing()
    new
    r !git log --pretty=oneline --abbrev-commit --graph @{u}..
    setlocal ft=git bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction

function! gitter#tags()
    new
    r !git log --oneline --decorate --tags --no-walk
    :normal ggdd
    setlocal ft=git bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction

function! gitter#show(object)
    new
    execute "r !git show ".a:object
    :normal ggdd
    setlocal ft=git bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction

function! gitter#help(command)
    new
    execute "r !git help " . a:command
    :normal ggdd
    setlocal ft=man bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction

function! gitter#status()
    20new
    execute "r !git status -sb "
    :normal ggdd
    setlocal ft=git bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction
