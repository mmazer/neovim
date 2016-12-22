" Tweaks to spacegray theme
hi clear
if exists("syntax_on")
  syntax reset
endif

runtime colors/spacegray.vim

set background=dark
let g:colors_name = "space"

hi MatchParen      ctermbg=NONE ctermfg=11      guibg=NONE     guifg=#E5C078  cterm=bold,underline  gui=bold,underline

hi Pmenu           ctermbg=0    ctermfg=NONE    guibg=#171717  guifg=#E8A973  cterm=none      gui=NONE
hi PmenuSel        ctermbg=234  ctermfg=196     guibg=#252525  guifg=#FF2A1F  cterm=NONE      gui=bold
hi PmenuSbar       ctermbg=233  ctermfg=000     guibg=#333233  guifg=#000000  cterm=NONE      gui=none
hi PmenuThumb      ctermbg=235  ctermfg=137     guibg=NONE     guifg=#171717  cterm=none      gui=none

" NERDTree
hi link NERDTreeDir NERDTreeDirSlash

" markdown
hi link  markdownH1 markdownHeadingDelimiter
hi link  markdownH2 markdownHeadingDelimiter
hi link  markdownH3 markdownHeadingDelimiter
hi link  markdownH4 markdownHeadingDelimiter
hi link  markdownH5 markdownHeadingDelimiter

