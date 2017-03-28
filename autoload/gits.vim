if exists('g:autoloaded_gits')
  finish
endif
let g:autoloaded_gits= 1

function! gits#diff_buff()
    let fname = expand('%')
    new
    exec "r! git diff ".printf('%s', fname)
    :normal ggdd
    setlocal ft=diff bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> qw :bw<cr>
endfunction

function! gits#diff_staged()
    new
    r !git diff -w --cached
    :normal ggdd
    setlocal ft=diff bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> qw :bw<cr>
endfunction

function! gits#diff_unstaged()
    new
    r !git diff -w
    :normal ggdd
    setlocal ft=diff bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> qw :bw<cr>
endfunction

function! gits#incoming()
    new
    r !git log --pretty=oneline --abbrev-commit --graph ..@{u}
    setlocal ft=git bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> qw :bw<cr>
endfunction

function! gits#outgoing()
    new
    r !git log --pretty=oneline --abbrev-commit --graph @{u}..
    setlocal ft=git bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> qw :bw<cr>
endfunction

function! gits#tags()
    new
    r !git log --oneline --decorate --tags --no-walk
    :normal ggdd
    setlocal ft=git bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> qw :bw<cr>
endfunction

function! gits#show(object)
    new
    execute "r !git show ".a:object
    :normal ggdd
    setlocal ft=git bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> qw :bw<cr>
endfunction

function! gits#help(command)
    new
    execute "r !git help " . a:command
    :normal ggdd
    setlocal ft=man bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> qw :bw<cr>
endfunction

function! gits#status()
    let sfile = tempname()
    silent execute ':!git status -sb > '. sfile.' 2>&1'
    silent execute ':pedit! '.sfile
    " switch to preview window
    wincmd P
    setlocal ft=git bt=nofile bh=wipe nobl noswf ro
    " switch back to previous window
    wincmd p
endfunction
