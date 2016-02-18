" Variables: {{{

let g:nvim_config = "~/.config/nvim"
let g:nvimrc = g:nvim_config . "/init.vim"
let g:localrc = g:nvim_config . "/local.vim"

let g:nvim_config_use_relinsert = 0
let g:nvim_config_abbrvs = g:nvim_config . "/abbr.vim"

" }}}

" Loading Plugins: {{{

call plug#begin(g:nvim_config . '/bundle')

Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-unimpaired'

Plug 'tpope/vim-commentary'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'FelikZ/ctrlp-py-matcher'

Plug 'benekastah/neomake'

Plug 'majutsushi/tagbar'

Plug 'SirVer/ultisnips'

Plug 'scrooloose/nerdtree'

Plug 'jeetsukumaran/vim-filebeagle'

Plug 'scrooloose/nerdtree'

Plug 'rking/ag.vim'

Plug 'davidoc/taskpaper.vim'

Plug 'mattn/calendar-vim'

Plug 'pangloss/vim-javascript'

Plug 'klen/python-mode'

Plug 'joukevandermaas/vim-ember-hbs'

Plug 'tpope/vim-markdown'

Plug 'mattn/emmet-vim'

Plug 'tpope/vim-projectionist'

Plug 'Raimondi/delimitMate'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf.vim'

Plug 'junegunn/gv.vim'

Plug 'epeli/slimux'

Plug 'nathanaelkane/vim-indent-guides'

Plug 'mmazer/vim-http-client'

Plug 'qpkorr/vim-bufkill'

call plug#end()

" }}}

" Basics: {{{

filetype plugin indent on

"}}}

" Moving: {{{

nnoremap g[ gg
nnoremap g] G

" Better mark jumping (line + col)
nnoremap <expr> ' printf('`%c zz', getchar())

nnoremap \c "+y
vnoremap \c "+y
nnoremap \p "+p

" For wrapped lines, navigate normally
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

nnoremap K H
" preserve J
nnoremap <space>j J
nnoremap J L
noremap H ^
noremap L $
vnoremap L g_

" center after next/previous change
nnoremap ]c ]czz
nnoremap [c [czz

" center window when moving to next search match
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" }}}

" Searching: {{{

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

" Displaying Text: {{{

set listchars=tab:▸\ ,trail:·,nbsp:¬
set list
set number
if (has("autocmd") && g:nvim_config_use_relinsert)
    augroup insert_number
        autocmd!
        autocmd InsertEnter * set norelativenumber
        autocmd InsertLeave * set relativenumber
    augroup END
endif

set scrolloff=2
set wrap linebreak textwidth=0

"}}}

" Syntax: {{{

syntax on
syntax sync minlines=256

" }}}

" Highlighting: {{{

set cursorline
let &colorcolumn="100,120"

" }}}

" Messages: {{{

" disable bell/visual bell
set noeb vb t_vb=
if has("autocmd")
    augroup visual_bell
        autocmd GUIEnter * set vb t_vb=
    augroup END
endif
set noshowcmd
set ruler
set shortmess=aTItoO

"}}}

" Editing Text: {{{

set completeopt=longest,menuone,preview
set showmatch
" avoid the escape key - remember <C-[> also maps to Esc
inoremap kj <ESC>`^

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
nnoremap =S :Strip<CR>

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nnoremap <silent> <leader>d "_d
vnoremap <silent> <leader>d "_d

" Quick yanking to the end of the line
nnoremap Y y$

" make it easier to work with some text objects
vnoremap ir i]
vnoremap ar a]
vnoremap ia i>
vnoremap aa a>
onoremap ir i]
onoremap ar a]
onoremap ia i>
onoremap aa a>

" end lines with semicolons
inoremap ;] <C-o>:call Preserve("s/\\s\*$/;/")<CR>
nnoremap <space>; :call Preserve("s/\\s\*$/;/")<CR>

" end lines with commas
inoremap ,] <C-o>:call Preserve("s/\\s\*$/,/")<CR>
nnoremap <space>, :call Preserve("s/\\s\*$/,/")<CR>

" toggle case of words
nnoremap [w gUiw
nnoremap ]w guiw

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" re-indent buffer and return to current position
nnoremap g= gg=G``

" http://vim.wikia.com/wiki/Show_the_length_of_the_current_word
command! Wlen :echo 'length of' expand('<cword>') 'is' strlen(substitute(expand('<cword>'), '.', 'x', 'g'))
nnoremap \wc :Wlen<CR>

" Source lines - from Steve Losh
vnoremap X y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap X ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" copy/yank filename
nnoremap <Leader>cf :let @+=expand('%:p')<CR>
nnoremap <Leader>cn :let @+=expand('%')<CR>
nnoremap <Leader>yf :let @"=expand('%:p')<CR>
nnoremap <Leader>yn :let @"=expand('%')<CR>

" }}} Editing Text

" Tabs and Indentation: {{{

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

" Folding: {{{

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

" toggling following vim-unimpaired
nnoremap [of :setlocal foldcolumn=3<CR>
nnoremap ]of :setlocal foldcolumn=0<CR>

" }}} Folding

" Reading and Writing Files: {{{

set autoread
set ffs=unix,dos,mac "Default file types
set ff=unix " set initial buffer file format
set modeline

set noswapfile
set backup
set backupdir=$HOME/.local/share/nvim/backup//

nnoremap g! :e!<CR>
nnoremap <space>w :w<CR>
nnoremap <space>W :w!<CR>
nnoremap <C-s> :w!<CR>
inoremap <C-s> <C-o>:w!<CR>

" show full path of file
nnoremap <space>p :echo expand('%')<CR>

noremap gov :execute 'edit' g:nvimrc <CR>
nnoremap gos :silent e ~/00INFOBASE/01FILES/SCRATCH.md<CR>
nnoremap goT :silent e ~/00INFOBASE/01FILES/TODO.taskpaper<CR>

" }}}

" Windows and Buffers: {{{

set hidden
set splitbelow
set splitright

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

nnoremap <space>B :b#<CR>
nnoremap <space>d :bp \| bd #<CR>

" goto buffer
nnoremap gb :ls<CR>:b

" quick fix window
nnoremap oq :copen<CR>
nnoremap qq :cclose<CR>

" location list
nnoremap ol :lopen<CR>
nnoremap ql :lclose<CR>

"}}}

" Tab Pages: {{{

nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap td  :tabclose<CR>

"}}}

" Colors: {{{

set t_Co=256
colorscheme monokai
set background=dark

" }}}

" Statusline: {{{

set laststatus=2
set statusline=%{Mode()}
set statusline+=%{&paste?'\ (paste)':'\ '}
set statusline+=\|
set statusline+=\ %{Branch()}
set statusline+=\ %f
set statusline+=\ %y      "filetype
set statusline+=%(\[%R%M\]%)      "modified flag
set statusline+=%=
set statusline+=\ %{StatuslineWhitespace()}
set statusline+=\ %{&expandtab?'\ (et)':'\ (noet)'}
set statusline+=\ %{&ff}  "file format
set statusline+=\ %{Fenc()} " file encoding
set statusline+=\ %5.l/%L\:%3.c\    "cursor line/total lines:column

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
    return empty(branch) ? '' : "git:".branch
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

" }}} Statusline

" Command Line: {{{

nmap <space><space> :
nmap <space>h :h<space>
nnoremap gh :h<space>
nnoremap <silent> Q :qa!<CR>

" }}}

" Spelling: {{{

set spelllang=en
set spellfile=~/.config/nvim/spell/spellfile.en.add

"}}}

" Plugin Settings: {{{

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

" ctrlp/fzf: {{{2

nmap <space> [ctrlp]
nnoremap <silent> [ctrlp]a :<C-u>CtrlPBookmarkDirAdd<cr>
nnoremap <silent> [ctrlp]b :Buffers<cr>
nnoremap <silent> [ctrlp]c :History:<CR>
nnoremap <silent> [ctrlp]C :BCommits<CR>
nnoremap <silent> [ctrlp]f :Files<CR>
nnoremap <silent> [ctrlp]g :GitFiles<CR>
nnoremap <silent> [ctrlp]l :Lines<CR>
nnoremap <silent> [ctrlp]m :Marks<CR>
nnoremap <silent> [ctrlp]o :<C-u>CtrlPBookmarkDir<cr>
nnoremap <silent> [ctrlp]q :<C-u>CtrlPQuickfix<cr>
nnoremap <silent> [ctrlp]s :BLines<CR>
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
    \ 'cucumber'    : '--language-force=cucumber',
    \ 'sh'          : '--language-force=sh'
    \ }

" }}} ctrlp/fzf

" ag:

" start search from project root
let g:ag_working_mode="r"
" workaround conflict with fzf.vim
command! -bang -nargs=* -complete=file AG call ag#Ag('grep<bang>',<q-args>)
nnoremap \\ :AG<space>

" tagbar: {{{2
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
"}}}

" neomake:
let g:neomake_open_list=2
let g:neomake_javascript_enabled_makers = ['jshint', 'jscs']
let g:neomake_error_sign = {
        \ 'text': 'E>',
        \ 'texthl': 'ErrorMsg'
        \ }
let g:neomake_warning_sign = {
        \ 'text': 'W>',
        \ 'texthl': 'ErrorMsg'
        \ }

" pymode
let g:pymode_lint = 0

" fugitive: {{{2

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

"}}} fugitive

" gitgutter {{{2

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
"}}}

" calendar:
command! -nargs=* Cal call calendar#show(1, <f-args>)

" emmet:
let g:user_emmet_expandabbr_key = '<C-e>'
let g:user_emmet_settings = {
            \ 'html' : {
            \    'indentation' : '  '
            \ },
            \}
" http-client:
nnoremap [r :HTTPClientDoRequest<CR>
command! Rest :HTTPClientDoRequest

" slimux:
map <Leader>c :SlimuxShellPrompt<CR>
map <Leader>s :SlimuxREPLSendLine<CR>
vmap <Leader>s :SlimuxREPLSendSelection<CR>
map <Leader>a :SlimuxShellLast<CR>
map <Leader>k :SlimuxSendKeysLast<CR>

" indent guides
let g:indent_guides_guide_size = 1
nmap <space>ig <Plug>IndentGuidesToggle

" }}} Plugin Settings

" AutoGroups: {{{

if has("autocmd")
    augroup Neomake
        autocmd!
        autocmd! BufWritePost * Neomake
    augroup END

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
        autocmd BufNewFile,BufRead fugitive://* set bufhidden=delete
        autocmd FileType gitcommit setlocal cursorline spell
        autocmd FileType handlebars setlocal shiftwidth=2 softtabstop=2 foldmethod=indent
        autocmd FileType html,css,javascript setlocal iskeyword+=-
        autocmd FileType html setlocal shiftwidth=2 softtabstop=2 tabstop=2 foldmethod=manual
        autocmd FileType html setlocal autoindent
        autocmd FileType scss setlocal shiftwidth=2 softtabstop=2 foldmethod=indent
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

" Functions: {{{

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
command! Cd :silent call Setcwd()
nnoremap gop :Cd<CR>:pwd<CR>

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

" Abbreviations: {{{

if filereadable(glob(g:nvim_config_abbrvs))
    exec 'source' g:nvim_config_abbrvs
endif

" }}}

" Local Configuration: {{{

if filereadable(glob(g:localrc))
    exec 'source' g:localrc
endif

" }}}
