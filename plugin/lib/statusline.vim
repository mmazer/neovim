set laststatus=2
set statusline+=%{Mode()}
set statusline+=\ %{Branch()}
set statusline+=\ %f
set statusline+=%(\ %R%M%)      "modified flag
set statusline+=%{&paste?'\ [paste]':''}
set statusline+=\ %{ALEGetStatusLine()}
set statusline+=%=
set statusline+=\ %{StatuslineWhitespace()}
set statusline+=\ %y      "filetype
set statusline+=\ %{&ff}  "file format
set statusline+=%{Fenc()} " file encoding
set statusline+=\ %{&expandtab?'spaces':'tabs'}
set statusline+=\ %5.l/%L\:%-3.c\    "cursor line/total lines:column
set statusline+=\ #%n

" Adapted from https://github.com/maciakl/vim-neatstatus
function! Mode()
    "redraw
    if &ft ==? "help"
        return "Help"
    endif

    if &ft ==? "diff"
        return "Diff"
    endif

    let l:mode = mode()

    if     mode ==# "n"  | return "N"
    elseif mode ==# "i"  | return "I"
    elseif mode ==# "c"  | return "C"
    elseif mode ==# "!"  | return "S"
    elseif mode ==# "R"  | return "R"
    elseif mode ==# "t"  | return "T"
    elseif mode ==# "v"  | return "V"
    elseif mode ==# "V"  | return "L"
    elseif mode ==# ""   | return "B"
    else                 | return l:mode
    endif
endfunction

function! Branch()
    if !exists('*fugitive#head')
        return ''
    endif

    let branch = fugitive#head()
    return empty(branch) ? '' : "⎇ ".branch.""
endfunction

function! Fenc()
    let enc = &fenc
    if enc == ''
        return enc
    endif

    if enc !~ "^$\|utf-8" || &bomb
        let enc = enc . (&bomb ? "-bom" : "" )
    endif

    return ':'.enc
endfun

" Detect trailing whitespace and mixed indentation
" Based on http://got-ravings.blogspot.ca/2008/10/vim-pr0n-statusline-whitespace-flags.html
function! StatuslineWhitespace()
    if &readonly || !&modifiable
        return ''
    endif

    if exists("b:statusline_whitespace")
        return b:statusline_whitespace
    endif

    let trailing = search('\s\+$', 'nw') != 0
    if trailing
        let trailing_warning = 'trail'
    else
        let trailing_warning = ''
    endif

    " check indents
    let tabs = search('^\t', 'nw') != 0
    let spaces = search('^ ', 'nw') != 0
    let mixed = tabs && spaces

    if mixed
        let tab_warning = 'mixed'
    elseif (spaces && !&et) || (tabs && &et)
        let tab_warning = '&et'
    else
        let tab_warning = ''
    endif

    if trailing || mixed
        let whitespace_warning = '['.trailing_warning
        if trailing && mixed
            let whitespace_warning.=':'
        endif
        let whitespace_warning.=tab_warning.']'
        let b:statusline_whitespace = whitespace_warning
    else
        let b:statusline_whitespace = ''
    endif

    return b:statusline_whitespace
endfunction

"recalculate the trailing whitespace warning when idle, and after saving
augroup statusline_whitespace
    autocmd CursorHold,BufWritePost * unlet! b:statusline_whitespace
augroup END
