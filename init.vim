let g:nvim_config = "~/.config/nvim"
let g:nvimrc = g:nvim_config . "/init.vim"
let g:localrc = g:nvim_config . "/local.vim"

let g:nvim_config_use_relinsert = 0
let g:nvim_config_abbrvs = g:nvim_config . "/abbr.vim"

" plugins: {{{

call plug#begin(g:nvim_config . '/bundle')

Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-unimpaired'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'FelikZ/ctrlp-py-matcher'

Plug 'scrooloose/syntastic'

Plug 'Valloric/YouCompleteMe'

Plug 'majutsushi/tagbar'

Plug 'SirVer/ultisnips'

Plug 'scrooloose/nerdtree'

Plug 'jeetsukumaran/vim-filebeagle'

Plug 'scrooloose/nerdtree'

Plug 'rking/ag.vim'

Plug 'davidoc/taskpaper.vim'

Plug 'mattn/calendar-vim'

Plug 'pangloss/vim-javascript'

Plug 'beyondwords/vim-twig'

Plug 'klen/python-mode'

Plug 'mustache/vim-mustache-handlebars'

Plug 'tpope/vim-markdown'

Plug 'mattn/emmet-vim'

Plug 'tpope/vim-projectionist'

Plug 'Raimondi/delimitMate'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf.vim'

Plug 'junegunn/gv.vim'

Plug 'epeli/slimux'

Plug 'nathanaelkane/vim-indent-guides'

call plug#end()

" }}}

" basic: {{{

filetype plugin indent on
set cursorline
set scrolloff=2
set listchars=tab:▸\ ,trail:·,nbsp:¬
set list
set shortmess=aTItoO
set ruler
set noshowcmd
set showmatch

" disable bell/visual bell
set noeb vb t_vb=
if has("autocmd")
    augroup visual_bell
        autocmd GUIEnter * set vb t_vb=
    augroup END
endif

"}}}

" line numbers: {{{

set number
if (has("autocmd") && g:nvim_config_use_relinsert)
    augroup insert_number
        autocmd!
        autocmd InsertEnter * set norelativenumber
        autocmd InsertLeave * set relativenumber
    augroup END
endif

"}}}

" search: {{{

set incsearch
set hlsearch
set ignorecase
set smartcase   "case sensitive if search term contains upppecase letter

if executable('ag')
    set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
    set grepformat=%f:%l:%c:%m
endif

" Use Perl/Ruby style regex patterns
" See http://briancarper.net/blog/448/
nnoremap / /\v
vnoremap / /\v

" }}}

" indentation: {{{

set expandtab
set shiftwidth=4
set softtabstop=4
let g:html_indent_inctags = "html,body,head,tbody"

function! TabToggle()
  if &expandtab
    set shiftwidth=8
    set softtabstop=0
    set noexpandtab
    echo "using tabs"
  else
    set shiftwidth=4
    set softtabstop=4
    set expandtab
    echo "using spaces"
  endif
endfunction
nnoremap coe :call TabToggle()<CR>
"}}}

" line wrap: {{{

set wrap linebreak textwidth=0

"}}}

" folding: {{{

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
    return marker . line . foldSizeStr
endfunction
set foldtext=CustomFoldText()

" }}}

" files: {{{

set modeline
set ffs=unix,dos,mac "Default file types
set ff=unix " set initial buffer file format
set noswapfile
set backup
set backupdir=$HOME/.local/share/nvim/backup//
set autoread

nnoremap g! :e!<CR>

" }}}

" syntax: {{{

syntax on
syntax sync minlines=256

" }}}

" windows: {{{

set hidden
set splitbelow
set splitright

"}}}

" buffers: {{{

" }}}

" colors: {{{

set t_Co=256
colorscheme monokai
set background=dark
let &colorcolumn="100,120"

" }}}

" status line: {{{

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
set statusline+=\ %{&ff}  "file format
set statusline+=:%{Fenc()} " file encoding
set statusline+=\ %{&expandtab?'\ (et)':'\ (noet)'}
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
    if !exists('*fugitive#head')
        return ''
    endif

    let branch = fugitive#head()
    return empty(branch) ? '' : '{git:'.branch.'}'
endfunction

function! Fenc()
    if &fenc == ''
        return "-"
    endif

    if &fenc !~ "^$\|utf-8" || &bomb
        return &fenc . (&bomb ? "-bom" : "" )
    else
        return "-"
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

" completion: {{{

set completeopt=longest,menuone,preview

" }}}

" mappings: {{{

nmap <space><space> :
nmap <space>h :h<space>

" Avoid the escape key - remember <C-[> also maps to Esc
inoremap kj <ESC>`^

nnoremap g[ gg
nnoremap g] G

" Better mark jumping (line + col)
nnoremap <expr> ' printf('`%c zz', getchar())

nnoremap \y "+y
nnoremap \p "+p

" For wrapped lines, navigate normally
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

inoremap <C-A> <C-o>^
inoremap <C-E> <C-o>$

nnoremap <silent> Q :qa!<CR>

noremap gov :execute 'edit' g:nvimrc <CR>

nnoremap <space>W :w!<CR>
command! W :w!

" for use in terminal - c-s must be disabled using stty -ixon
nnoremap <C-s> :w!<CR>
inoremap <C-s> <C-o>:w!<CR>
nnoremap <space>w :w<CR>
nnoremap <space>B :b#<CR>
nnoremap <space>d :bp \| bd #<CR>

" goto buffer
nnoremap gb :ls<CR>:b

" Source lines - from Steve Losh
vnoremap X y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap X ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

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
noremap <silent>  //+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> //- :exe "resize " . (winheight(0) * 2/3)<CR>

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

nnoremap gh :h<space>

" quick fix window
nnoremap oq :copen<CR>
nnoremap qq :cclose<CR>

nnoremap ol :lopen<CR>
nnoremap ql :lclose<CR>

" end lines with semicolons
inoremap ;] <C-o>:call Preserve("s/\\s\*$/;/")<CR>
nnoremap <space>; :call Preserve("s/\\s\*$/;/")<CR>

" end lines with commas
inoremap ,] <C-o>:call Preserve("s/\\s\*$/,/")<CR>
nnoremap <space>, :call Preserve("s/\\s\*$/,/")<CR>

" toggle case of words
nnoremap [w gUiw
nnoremap ]w guiw

" copy/yank filename
nnoremap <Leader>cf :let @+=expand('%:p')<CR>
nnoremap <Leader>cn :let @+=expand('%')<CR>
nnoremap <Leader>yf :let @"=expand('%:p')<CR>
nnoremap <Leader>yn :let @"=expand('%')<CR>

" show full path of file
nnoremap <space>p :echo expand('%')<CR>

" http://vim.wikia.com/wiki/Show_the_length_of_the_current_word
command! Wlen :echo 'length of' expand('<cword>') 'is' strlen(substitute(expand('<cword>'), '.', 'x', 'g'))
nnoremap \wc :Wlen<CR>

" }}}

" spelling: {{{

set spelllang=en
set spellfile=~/.config/nvim/spell/spellfile.en.add

"}}}

" macros: {{{

runtime macros/matchit.vim

" }}}

" plugin settings: {{{

" nerdtree
let NERDChristmasTree=1
let NERDTreeWinSize=35
let NERDTreeDirArrows=1
let NERDTreeIgnore=['\.pyc$']

noremap <silent> <C-T> :NERDTreeToggle<CR>
noremap <space>nc :NERDTreeClose<CR>
noremap <silent> gon :NERDTreeFind<CR>
noremap <space>no :NERDTree %:p:h<CR>

" ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets="<c-h>"

" YCM
let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1

" ctrlp:
" fzf:
nmap <space> [ctrlp]
nnoremap <silent> [ctrlp]a :<C-u>CtrlPBookmarkDirAdd<cr>
nnoremap <silent> [ctrlp]b :Buffers<cr>
nnoremap <silent> [ctrlp]c :History:<CR>
nnoremap <silent> [ctrlp]C :<C-u>CtrlPClearCache<cr>
nnoremap <silent> [ctrlp]f :Files<CR>
nnoremap <silent> [ctrlp]l :BLines<CR>
nnoremap <silent> [ctrlp]m :Marks<CR>
nnoremap <silent> [ctrlp]o :<C-u>CtrlPBookmarkDir<cr>
nnoremap <silent> [ctrlp]q :<C-u>CtrlPQuickfix<cr>
nnoremap <silent> [ctrlp]s :History/<CR>
nnoremap <silent> [ctrlp]t :<C-u>CtrlPBufTag<cr>
nnoremap <silent> [ctrlp]u :<C-u>CtrlPMRUFiles<cr>


let g:ctrlp_extensions = ['quickfix', 'undo', 'line', 'changes', 'mixed', 'buffertag', 'bookmarkdir']
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

let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

if executable('ag')
    let g:ctrlp_user_command = 'ag -l --nocolor --follow -g "" %s'
    let g:ctrlp_use_caching = 1
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
    \ 'markdown'    : '--language-force=markdown',
    \ 'cucumber'    : '--language-force=cucumber'
    \ }

" ag
" start search from project root
let g:ag_working_mode="r"
" workaround conflict with fzf.vim
command! -bang -nargs=* -complete=file Agg call ag#Ag('grep<bang>',<q-args>)

" tagbar
noremap <silent> [ot :TagbarOpen fg<CR>
noremap <silent> ]ot :TagbarClose<CR>
noremap <silent> cot :TagbarToggle<CR>

let g:tagbar_type_javascript = {
    \ 'ctagstype'   :'js',
    \ 'kinds'       : [
        \ 'o:objects',
        \ 'f:functions'
    \ ]
\ }

let g:tagbar_type_html = {
    \ 'ctagstype'   :'xml',
    \ 'kinds'       : [
        \ 'e:elements'
    \ ]
\ }

" syntastic:
let g:syntastic_check_on_open = 0
let g:syntastic_filetype_map = {
    \ "html.handlebars": "handlebars"
    \ }
let g:syntastic_javascript_checkers=['jshint', 'jscs']
let g:syntastic_error_symbol='E:'
let g:syntastic_warning_symbol='W:'
let g:syntastic_always_populate_loc_list= 1
let g:syntastic_python_checkers=['flake8']
let g:syntastic_stl_format = '| ✗ %E{E: %fe #%e}%B{, }%W{W: %fw #%w} | '

let g:syntastic_mode_map = { 'mode': 'active',
            \ 'passive_filetypes': ['xml', 'java'] }

let g:syntastic_html_tidy_exec = 'tidy5'
let g:syntastic_html_tidy_ignore_errors = [
    \ " proprietary attribute "
    \ ]

nnoremap <Leader>s :SyntasticCheck<CR>

" pymode
let g:pymode_lint = 0

" fugitive:
nnoremap <space>gs :Gstatus<CR>
nnoremap <space>gb :Gblame<CR>
nnoremap <space>gc :Gcommit -v -q <CR>
nnoremap <space>gd :Gdiff<CR>
nnoremap <space>ge :Gedit<CR>
nnoremap <space>gl :Glog<CR>
nnoremap <space>gr :Gread<CR>
nnoremap <space>gw :Gwrite<CR>
nnoremap <space>gp :Ggrep<CR>

" Simple way to turn off Gdiff splitscreen
" works only when diff buffer is focused
" https://gist.github.com/radmen/5048080
command! Gdoff diffoff | q | Gedit

function! GitDiffStaged()
    new
    r !git diff -w --cached
    :normal ggdd
    setlocal ft=diff bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction
command! Gdiffstaged :call GitDiffStaged()
nnoremap <space>gt :Gdiffstaged<CR>

function! GitDiffUnstaged()
    new
    r !git diff -w
    :normal ggdd
    setlocal ft=diff bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction
command! GdiffUnstaged :call GitDiffUnstaged()
nnoremap <space>gu :GdiffUnstaged<CR>

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

" gitgutter

let g:gitgutter_enabled = 0
let g:gitgutter_diff_args = '-w'
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '='
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_modified_removed = '~'
nnoremap [og :GitGutterEnable<CR>
nnoremap ]og :GitGutterDisable<CR>
nnoremap cog :GitGutterToggle<CR>
nnoremap ]gg :GitGutterNextHunk<CR>zz
nnoremap [gg :GitGutterPrevHun<CR>zz

nnoremap [gh :GitGutterStageHunk<CR>
nnoremap ]gh :GitGutterRevertHunk<CR>

" calendar:
command! -nargs=* Cal call calendar#show(1, <f-args>)

" ag
nnoremap \ :Ag<space>

" emmet:
let g:user_emmet_leader_key = '<C-x>'
let g:user_emmet_settings = {
\ 'html' : {
\    'indentation' : '  '
\ },
\}
" }}}
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" slimux:
map <Leader>c :SlimuxShellPrompt<CR>
map <Leader>s :SlimuxREPLSendLine<CR>
vmap <Leader>s :SlimuxREPLSendSelection<CR>
map <Leader>a :SlimuxShellLast<CR>
map <Leader>k :SlimuxSendKeysLast<CR>

" indent guides
let g:indent_guides_guide_size = 1
nmap <space>ig <Plug>IndentGuidesToggle

" autocommands: {{{
if has("autocmd")
    augroup Preview
        autocmd!
        autocmd CompleteDone * pclose
    augroup END

    " remove trailing whitespace
    augroup StripWhitespace
        autocmd!
        autocmd! FileType vim,css,groovy,java,javascript,less,php,scala,taskpaper,python,ruby,
                    \handlebars,html.handlebars autocmd BufWritePre <buffer> :%s/\s\+$//e
    augroup END

    augroup FTOptions
        autocmd!
        autocmd FileType cucumber setlocal shiftwidth=2 softtabstop=2 foldmethod=indent
        autocmd BufRead fugitive\:* xnoremap <buffer> dp :diffput<CR>|xnoremap <buffer> do :diffget<CR>
        autocmd BufReadPost fugitive://* set bufhidden=delete
        autocmd FileType gitcommit setlocal cursorline spell
        autocmd FileType handlebars setlocal shiftwidth=2 softtabstop=2 foldmethod=indent
        autocmd FileType html.handlebars setlocal shiftwidth=2 softtabstop=2 foldmethod=indent
        autocmd FileType html,css,javascript setlocal iskeyword+=-
        autocmd FileType html setlocal shiftwidth=2 softtabstop=2 tabstop=2 foldmethod=manual
        autocmd FileType html setlocal autoindent
        autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 foldmethod=indent
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType json command! Format :%!python -m json.tool<CR>
        autocmd FileType json setlocal foldmethod=syntax
        autocmd FileType json setlocal foldnestmax=10
        autocmd FileType markdown  set suffixesadd=.txt,.md
        autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2 foldmethod=indent
        autocmd FileType scheme autocmd BufWritePre <buffer> :%s/\s\+$//e
        autocmd Filetype vim set foldmethod=marker
    augroup END

    augroup DiffMode
        autocmd FilterWritePre * if &diff | nnoremap <buffer> dc :Gdoff<CR> | nnoremap <buffer> du :diffupdate<CR> | endif
    augroup END
endif

" }}}

" functions: {{{

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

function! StripTrailingWhitespace()
    call Preserve("%s/\\s\\+$//e")
endfunction
command! Strip :call StripTrailingWhitespace()

function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction
command! Syntax :echo SyntaxItem()

function! ShowTime()
    echo strftime('%a %d %b %H:%M:%S')
endfunction
nnoremap got :call ShowTime()<CR>

nnoremap <space>n :echo expand('%')<CR>

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

function! OpenURI()
    " 2011-01-21 removed colon ':' from regexp to allow for port numbers in URLs
    " original regexp: [a-z]*:\/\/[^ >,;:]*
    let uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;\)\"]*')
    if uri != ""
        let uri = escape(uri, "#%; ")
        echo uri

        if has('win32')
            exec ":silent !cmd /C start /min " . uri
        elseif has('mac')
            exec ":silent !open \"" . printf("%s", uri) . "\""
        elseif has('unix')
            exec ":silent !firefox \"" . printf("%s", uri) . "\""
        else
            echo "OpenURI not supported on this system"
        endif
        exec ":redraw!"
    else
        echo "No URI found in line."
    endif
endfunction
noremap gou :call OpenURI()<CR>

" }}}

" commands: {{{

nnoremap gos :silent e ~/00INFOBASE/00INBOX/SCRATCH.txt<CR>
nnoremap goT :silent e ~/00INFOBASE/01FILES/TODO.taskpaper<CR>

if executable("dos2unix")
    command! Dos2Unix :%!dos2unix
endif
" }}}

" abbreviations: {{{

:iab dts <c-r>=DateTimeStamp()<esc>
:iab ddt <c-r>=ShortDate()<esc>

if filereadable(glob(g:nvim_config_abbrvs))
    exec 'source' g:nvim_config_abbrvs
endif

" local configuration
if filereadable(glob(g:localrc))
    exec 'source' g:localrc
endif

