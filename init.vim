" 1: important {{{
let g:nvim_config = "~/.config/nvim"
let g:nvim_init = g:nvim_config . "/init.vim"

call plug#begin(g:nvim_config . '/bundle')

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-unimpaired'

Plug 'jreybert/vimagit'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'scrooloose/syntastic'

Plug 'Valloric/YouCompleteMe'

Plug 'majutsushi/tagbar'

Plug 'SirVer/ultisnips'

Plug 'scrooloose/nerdtree'

Plug 'jeetsukumaran/vim-filebeagle'

Plug 'rking/ag.vim'

call plug#end()

" }}}

" 2: moving around, searching and patterns {{{

set incsearch
set hlsearch
set ignorecase
set smartcase   "case sensitive if search term contains upppecase letter

" }}}

" 4: displaying text {{{
set scrolloff=2
set listchars=tab:▸\ ,trail:·,nbsp:¬
set wrap linebreak textwidth=0
set number
augroup insert_number
    autocmd InsertEnter * set norelativenumber
    autocmd InsertLeave * set relativenumber
augroup END
" }}}

" 5: syntax, highlighting and spelling {{{

filetype plugin indent on
syntax on
syntax sync minlines=256
set cursorline

set spelllang=en
set spellfile=~/.config/nvim/spell/spellfile.en.add

" }}}

" 6: multiple windows {{{1
set hidden
set splitbelow
set splitright

" status line
set laststatus=2
set statusline=%{Mode()}
set statusline+=%{&paste?'\ (paste)':'\ '}
set statusline+=\|
set statusline+=\ %{Branch()}
set statusline+=\ %f
set statusline+=\ \[\#%n\]
set statusline+=%(\[%R%M\]%)      "modified flag
set statusline+=\ %{SyntasticStatuslineFlag()}
set statusline+=%=
set statusline+=\ %{StatuslineWhitespace()}
set statusline+=\ %y      "filetype
set statusline+=\ %{Fenc()} " file encoding
set statusline+=\[%{&ff}\]  "file format
set statusline+=\ %5.l/%L\:%c\    "cursor line/total lines:column

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

    if     mode ==# "n"  | return "NOR"
    elseif mode ==# "i"  | return "INS"
    elseif mode ==# "c"  | return "COM"
    elseif mode ==# "!"  | return "SHE"
    elseif mode ==# "R"  | return "REP"
    elseif mode ==# "v"  | return "VIS"
    elseif mode ==# "V"  | return "V-L"
    elseif mode ==# ""   | return "V-B"
    else                 | return l:mode
    endif
endfunction

function! Branch()
    let branch = ''
    if !exists('*fugitive#head')
        return branch
    endif

    let branch = fugitive#statusline()
    return branch
endfunction

function! Fenc()
    if &fenc !~ "^$\|utf-8" || &bomb
        return &fenc . (&bomb ? "-bom" : "" )
    else
        return "none"
    endif
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
" }}}

" 10: gui {{{

set t_Co=256
set background=dark
colorscheme monokai

" }}}

" 12: messages and info {{{

set shortmess=aTItoO
set ruler
set noshowcmd
" disable bell/visual bell
set noeb vb t_vb=
augroup visual_bell
    autocmd GUIEnter * set vb t_vb=
augroup END

" }}}

" 15: tabs and indenting {{{1

set expandtab
set shiftwidth=4
set softtabstop=4
let g:html_indent_inctags = "html,body,head,tbody"

" }}}

" 16: folding {{{1

set foldmethod=syntax                   "fold based on indent
set foldnestmax=2                       "deepest fold is 10 levels
set nofoldenable                        "don't fold by default
let g:xml_syntax_folding=1              "enable xml folding

nnoremap <Space>z za
vnoremap <Space>z za

" refocus fold under cursor - from Steve Losh
nnoremap ,z zMzvzz

"http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
function! CustomFoldText()
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&numberend ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " (" . foldSize . " lines) "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let marker = "» "
    let expansionString = repeat(".", w - strwidth(marker.foldSizeStr.line.foldLevelStr.foldPercentage))
    "return marker . line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
    return marker . line . foldSizeStr
endfunction
set foldtext=CustomFoldText()

" }}}

" 18: mappings {{{

nnoremap g<space> :

nnoremap g[ gg
nnoremap g] G

" Better mark jumping (line + col)
nnoremap <expr> ' printf('`%c zz', getchar())

" for toggling paste mode in terminal
" Can also use `yo` from `unimpaired`
set pastetoggle=<F5>
nnoremap \p "*p

" For wrapped lines, navigate normally
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

inoremap <C-A> <C-o>^
inoremap <C-E> <C-o>$

nnoremap <silent> Q :qa!<CR>

noremap \\v :execute 'edit' g:nvim_init<CR>

nnoremap <space>W :w!<CR>
command! W :w!

" for use in terminal - c-s must be disabled using stty -ixon
nnoremap <C-s> :w!<CR>
inoremap <C-s> <C-o>:w!<CR>
nnoremap <space>w :w<CR>
nnoremap <space>B :b#<CR>
nnoremap <space>d :bd<CR>

" goto buffer
nnoremap gb :ls<CR>:b

nmap <space><space> :

" Source lines - from Steve Losh
vnoremap X y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap X ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" Avoid the escape key - remember <C-[> also maps to Esc
inoremap kj <ESC>`^

" Prefer to use Perl/Ruby style regex patterns
" See http://briancarper.net/blog/448/
nnoremap / /\v
vnoremap / /\v

nnoremap <space>j J

nnoremap K H
nnoremap J L
noremap H ^
noremap L $
vnoremap L g_

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nnoremap <silent> <leader>d "_d
vnoremap <silent> <leader>d "_d

" Quick yanking to the end of the line
nnoremap Y y$

" manage windows
nnoremap W <C-w>

" window navigation: use ctrl-h/j/k/l to switch between splits
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" Resize windows using a reasonable amount
" http://flaviusim.com/blog/resizing-vim-window-splits-like-a-boss/
noremap <silent> <S-Up> :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <S-Down> :exe "resize " . (winheight(0) * 2/3)<CR>

" tab navigation
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap td  :tabclose<CR>

" center window when moving to next search match
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" toggling following vim-unimpaired
nnoremap [of :setlocal foldcolumn=3<CR>
nnoremap ]of :setlocal foldcolumn=0<CR>

" make it easier to work with some text objects
vnoremap ir i]
vnoremap ar a]
vnoremap ia i>
vnoremap aa a>
onoremap ir i]
onoremap ar a]
onoremap ia i>
onoremap aa a>

" }}}

" 19: reading and writing files {{{1

set modeline
set ffs=unix,dos,mac "Default file types
set ff=unix " set initial buffer file format
set backup
set backupdir=$HOME/.var/vim/backup//
set autoread

nnoremap g! :e!<CR>
" }}}

" 23: running make and jumping to errors {{{1

if executable('ag')
    set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
    set grepformat=%f:%l:%c:%m
endif

" }}}

" 28: plugin settings {{{

" ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"

" ctrlp:
nmap <space> [ctrlp]
nnoremap <silent> [ctrlp]a :<C-u>CtrlPBookmarkDirAdd<cr>
nnoremap <silent> [ctrlp]b :<C-u>CtrlPBuffer<cr>
nnoremap <silent> [ctrlp]c :<C-u>CtrlPCmdline<cr>
nnoremap <silent> [ctrlp]C :<C-u>CtrlPClearCache<cr>
nnoremap <silent> [ctrlp]d :<C-u>CtrlPDir<cr>
nnoremap <silent> [ctrlp]f :<C-u>CtrlP<cr>
nnoremap <silent> [ctrlp]k :<C-u>CtrlPMark<cr>
nnoremap <silent> [ctrlp]m :<C-u>CtrlPMixed<cr>
nnoremap <silent> [ctrlp]o :<C-u>CtrlPBookmarkDir<cr>
nnoremap <silent> [ctrlp]r :<C-u>CtrlPRegister<cr>
nnoremap <silent> [ctrlp]q :<C-u>CtrlPQuickfix<cr>
nnoremap <silent> [ctrlp]s :<C-u>CtrlPFunky<cr>
nnoremap <silent> [ctrlp]t :<C-u>CtrlPBufTag<cr>
nnoremap <silent> [ctrlp]u :<C-u>CtrlPMRUFiles<cr>
nnoremap <silent> [ctrlp]y :<C-u>CtrlPYankring<cr>


let g:ctrlp_extensions = ['quickfix', 'dir', 'undo', 'line', 'changes', 'mixed', 'buffertag', 'bookmarkdir', 'funky', 'mark', 'register']
let g:ctrlp_match_window_bottom = 1 " Show at top of window
let g:ctrlp_working_path_mode = 'ra' " Smart path mode
let g:ctrlp_mru_files = 1 " Enable Most Recently Used files feature
let g:ctrlp_jump_to_buffer = 2 " Jump to tab AND buffer if already open
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_root_markers = ['.top', '.project', '.ctrlp']
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_custom_ignore = {
    \ 'dir':  '.git\|.svn\|target\|node_modules\|.settings'
    \ }

if executable('ag')
    let g:ctrlp_user_command = 'ag -l --nocolor --follow -g "" %s'
    let g:ctrlp_use_caching = 0
endif

" ctrlp_buftag
let g:ctrlp_buftag_types = {
    \ 'javascript'  : '--language-force=js',
    \ 'css'         : '--language-force=css',
    \ 'gsp'         : '--language-force=XML',
    \ 'xml'         : '--language-force=XML',
    \ 'spring'      : '--language-force=XML',
    \ 'jsp'         : '--language-force=XML',
    \ 'html'        : '--language-force=XML',
    \ 'taskpaper'   : '--language-force=Taskpaper',
    \ 'wsdl'        : '--language-force=wsdl',
    \ 'markdown'    : '--language-force=markdown'
    \ }

" fugitive
nnoremap GB :Gblame<CR>
nnoremap GC :Gcommit<CR>
nnoremap Gd :Gdiff<CR>
nnoremap Ge :Gedit<CR>
nnoremap Gl :Glog<CR>
nnoremap Gs :Gstatus<CR>
nnoremap Gr :Gread<CR>
nnoremap Gw :Gwrite<CR>

" Simple way to turn off Gdiff splitscreen
" works only when diff buffer is focused
" https://gist.github.com/radmen/5048080
command! Gdoff diffoff | q | Gedit

function! GitDiffCached()
    new
    r !git diff -w --cached
    :normal ggdd
    setlocal ft=diff bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction
command! Gdiffcached :call GitDiffCached()
nnoremap Gc :Gdiffcached<CR>

function! GitDiffBuf()
    let fname = expand('%')
    new
    exec "r! git diff ".printf('%s', fname)
    :normal ggdd
    setlocal ft=diff bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction
nnoremap Gb :call GitDiffBuf()<CR>

function! GitIncoming()
    new
    r !git log --pretty=oneline --abbrev-commit --graph ..@{u}
    setlocal ft=git bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction
command! Gincoming :call GitIncoming()
nnoremap Gi :Gincoming<CR>

function! GitOutgoing()
    new
    r !git log --pretty=oneline --abbrev-commit --graph @{u}..
    setlocal ft=git bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction
command! Goutgoing :call GitOutgoing()
nnoremap Go :Goutgoing<CR>

" calendar:
command! -nargs=* Cal call calendar#show(1, <f-args>)

" }}}

" 28: autocommands {{{
if has("autocmd")
    augroup preview
        autocmd CompleteDone * pclose
    augroup END

    " remove trailing whitespace
    augroup trailing_whitespace
        autocmd! FileType vim,css,groovy,java,javascript,less,php,scala,taskpaper,python autocmd BufWritePre <buffer> :%s/\s\+$//e
    augroup END

    augroup keyword
        autocmd FileType html,css,javascript setlocal iskeyword+=-
    augroup END

    augroup vim_files
        autocmd filetype vim set foldmethod=marker
    augroup END

    augroup fugitive_buffers
        autocmd BufRead fugitive\:* xnoremap <buffer> dp :diffput<CR>|xnoremap <buffer> do :diffget<CR>
        autocmd BufReadPost fugitive://* set bufhidden=delete
        autocmd FileType gitcommit setlocal cursorline
    augroup END

    augroup diff_mode
        autocmd FilterWritePre * if &diff | nnoremap <buffer> dc :Gdoff<CR> | nnoremap <buffer> du :diffupdate<CR> | endif
    augroup END

endif

" }}}

" 29: functions {{{

function! DateTimeStamp()
    return strftime("%H:%M-%m.%d.%Y")
endfun

function! ShortDate()
    return strftime("%Y-%m-%d")
endfun

function! QuickLook()
    if has('mac')
        exec ":silent !ql \"%\""
    else
        echo "Quicklook not supported on this system"
    endif
endfunction
nnoremap gol :call QuickLook()<CR>

function! Marked()
        exec ":silent !marked \"%\""
endfunction
command! Marked :call Marked()

" Save last search and cursor position before executing a command
" http://technotales.wordpress.com/2010/03/31/preserve-a-vim-function-that-keeps-your-state/
function! Preserve(command)
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction
command! Syntax :echo SyntaxItem()

function! ShowTime()
    echo strftime('%a %d %b %H:%M:%S')
endfunction
nnoremap got :call ShowTime()<CR>


" Taken from ctrlp help file
function! Setcwd()
    let cph = expand('%:p:h', 1)
    if cph =~ '^.\+://' | retu | en
    for mkr in ['.git/', '.hg/', '.svn/', '.bzr/', '_darcs/', '.vimprojects', '.project', '.ctrlp', '.top']
        let wd = call('find'.(mkr =~ '/$' ? 'dir' : 'file'), [mkr, cph.';'])
        if wd != '' | let &acd = 0 | brea | en
    endfo
    exe 'lc!' fnameescape(wd == '' ? cph : substitute(wd, mkr.'$', '.', ''))
endfunction
command! Cd :silent call Setcwd() | pwd

" }}}

" 30: user commands {{{

if executable("dos2unix")
    command! Dos2Unix :%!dos2unix
endif
" }}}

" 31 abbreviations {{{

:iab dts <c-r>=DateTimeStamp()<esc>
:iab ddt <c-r>=ShortDate()<esc>

let b:abbrvs = g:nvim_config . "/abbr.vim"
if filereadable(glob(b:abbrvs))
    exec 'source' b:abbrvs
endif
