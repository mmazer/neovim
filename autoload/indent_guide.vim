if exists("g:autoloaded_indent_guide")
  finish
endif

let g:autoloaded_indent_guide = 1

if !exists('g:indent_guide_higroup')
  let g:indent_guide_higroup = 'CursorLine'
endif

" http://stackoverflow.com/questions/2158305/is-it-possible-to-display-indentation-guides-in-vim
function! indent_guide#toggle()
    if exists('b:indent_guides')
        call matchdelete(b:indent_guides)
        unlet b:indent_guides
    else
        let pos = range(1, &l:textwidth, &l:shiftwidth)
        call map(pos, '"\\%" . v:val . "v"')
        let pat = '\%(\_^\s*\)\@<=\%(' . join(pos, '\|') . '\)\s'
        let b:indent_guides = matchadd(g:indent_guide_higroup, pat)
    endif
endfunction

