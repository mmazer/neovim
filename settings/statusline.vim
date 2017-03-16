set laststatus=2
set statusline+=%{statsline#mode()}
set statusline+=\ %{statsline#branch()}
set statusline+=\ %f
set statusline+=%(\ %R%M%)      "modified flag
set statusline+=%{&paste?'\ [paste]':''}
set statusline+=\ %{statsline#current_tag()}
set statusline+=\ %{ALEGetStatusLine()}
set statusline+=%=
set statusline+=\ %{statsline#whitespace()}
set statusline+=\ %y      "filetype
set statusline+=\ %{&ff}  "file format
set statusline+=%{statsline#fenc()} " file encoding
set statusline+=\ %{&expandtab?'spaces':'tabs'}
set statusline+=\ %5.l/%L\:%-3.c\    "cursor line/total lines:column
set statusline+=\ #%n

command! ToggleCurrentTag :call statsline#toggle_current_tag()

"recalculate the trailing whitespace warning when idle, and after saving
augroup statusline_whitespace
    autocmd CursorHold,BufWritePost * unlet! b:statusline_whitespace
augroup END
