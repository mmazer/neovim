if exists("g:loaded_gitter")
  finish
endif

let g:loaded_gitter = 1

command! GdiffBuf :call gitter#diff_buf()

command! Gdiffstaged :call gitter#diff_staged()

command! GdiffUnstaged :call gitter#diff_unstaged()

command! Gincoming :call gitter#incoming()

command! Goutgoing :call gitter#outgoing()

command! Gtags :call gitter#tags()

command! -nargs=1 Gshow call gitter#show(<f-args>)

command! -nargs=1 Ghelp call gitter#help(<f-args>)

command! GitStat :call gitter#status()
