if exists("g:autoloaded_statsline")
  finish
endif

let g:autoloaded_statsline = 1

" Adapted from https://github.com/maciakl/vim-neatstatus
function! statsline#mode()
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

function! statsline#branch()
    if !exists('*fugitive#head')
        return ''
    endif

    let branch = fugitive#head(7)
    return empty(branch) ? '' : "⎇ ".branch.""
endfunction

function! statsline#fenc()
    let enc = &fenc
    if enc == ''
        return enc
    endif

    if enc !~ "^$\|utf-8" || &bomb
        let enc = enc . (&bomb ? "-bom" : "" )
    endif

    return ':'.enc
endfun

function! statsline#current_tag()
    let l:tag = ''
    if g:nvim_show_current_tag && exists(':Tagbar')
        let l:tag = tagbar#currenttag('[%s]', '')
    endif
    return l:tag
endfunction

function! statsline#toggle_current_tag()
    if g:nvim_show_current_tag == 1
        let g:nvim_show_current_tag = 0
    else
        let g:nvim_show_current_tag = 1
    endif
endfunction

" Detect trailing whitespace and mixed indentation
" Based on http://got-ravings.blogspot.ca/2008/10/vim-pr0n-statusline-whitespace-flags.html
function! statsline#whitespace()
    if exists('b:statusline_ignore_whitespace')
        return ''
    endif

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

