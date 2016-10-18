" Variables: {{{

let g:nvim_config = "~/.config/nvim"
let g:nvimrc = g:nvim_config . "/init.vim"
let g:local_config = "~/.config/local/nvim/init.vim"
let g:nvim_bundle=g:nvim_config.'/bundle'
let g:nvim_autocompletion_enabled = 0
let g:nvim_config_use_relinsert = 1
let g:nvim_abbrvs = g:nvim_config . "/abbr.vim"
let g:jira_browse = ""
let g:infobase_scratch_file = "~/00INFOBASE/01FILES/SCRATCH.md"
let g:infobase_reading_list = "~/Dropbox/00INFOBASE/01FILES/reading-list.txt"

" }}}

" Important: {{{

let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1

" }}}

" Loading Plugins: {{{

call plug#begin(g:nvim_bundle)

Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-unimpaired'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-cucumber'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'benekastah/neomake'

Plug 'SirVer/ultisnips'

Plug 'jeetsukumaran/vim-filebeagle'

Plug 'scrooloose/nerdtree'

Plug 'rking/ag.vim'

Plug 'davidoc/taskpaper.vim'

Plug 'pangloss/vim-javascript'

Plug 'mustache/vim-mustache-handlebars'

Plug 'tpope/vim-markdown'

Plug 'rodjek/vim-puppet'

Plug 'mattn/emmet-vim'

Plug 'tpope/vim-projectionist'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf.vim'

Plug 'junegunn/gv.vim'

Plug 'Yggdroot/indentLine'

Plug 'jiangmiao/auto-pairs'

Plug 'qpkorr/vim-bufkill'

function! UpdateRemote(arg)
    UpdateRemotePlugins
endfunction

Plug 'Shougo/deoplete.nvim', { 'do': function('UpdateRemote') }

if has("mac")
    Plug 'rizzatti/dash.vim'
endif

Plug 'ajh17/Spacegray.vim'

Plug 'AlessandroYorba/Despacio'

Plug 'davidhalter/jedi-vim'

Plug 'majutsushi/tagbar'

call plug#end()

" }}}

" Basics: {{{

filetype plugin indent on

"}}}

" Moving: {{{

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

" center moving when jumping bac
nnoremap <C-o> <C-o>zz

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

set listchars=tab:▸\ ,trail:·,nbsp:¬,extends:›,precedes:‹
set list
set number
if has("autocmd") && g:nvim_config_use_relinsert
    set relativenumber
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
let &colorcolumn="110"

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
nnoremap <silent> ,d "_d
vnoremap <silent> ,d "_d

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
inoremap ;] <C-\><C-O>:call Preserve("s/\\s\*$/;/")<CR>
nnoremap <space>; :call Preserve("s/\\s\*$/;/")<CR>

" end lines with commas
inoremap ,] <C-\><C-O>:call Preserve("s/\\s\*$/,/")<CR>
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

nnoremap gov :exec 'edit' g:nvimrc <CR>
nnoremap gos :exec 'edit' g:infobase_scratch_file<CR>
nnoremap gor :exec 'edit' g:infobase_reading_list<CR>

" }}}

" Windows and Buffers: {{{

set hidden
set splitbelow
set splitright

" manage windows
nnoremap W <C-w>

" window navigation consistent with term mode mappings
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize windows using a reasonable amount
" http://flaviusim.com/blog/resizing-vim-window-splits-like-a-boss/
noremap <silent>  //+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> //- :exe "resize " . (winheight(0) * 2/3)<CR>

nnoremap <space>B :b#<CR>
nnoremap <space>d :bp \| bd #<CR>
nnoremap <space>D :BD<CR> " use buffkil

" goto buffer
nnoremap gob :ls<CR>:b

nnoremap goe :enew<CR>

" close quick fix and location list
nnoremap qq :cclose<CR>
nnoremap ql :lclose<CR>

"}}}

" Tab Pages: {{{

nnoremap th :tabfirst<CR>
nnoremap tj :tabnext<CR>
nnoremap tk :tabprev<CR>
nnoremap tl :tablast<CR>
nnoremap td :tabclose<CR>

"}}}

" Colors: {{{

set termguicolors
set background=dark
colorscheme despacio

" }}}

" Statusline: {{{

set laststatus=2
set statusline+=%{Branch()}
set statusline+=\ %f
set statusline+=%(\ %R%M%)      "modified flag
set statusline+=%{&paste?'\ [paste]':''}
set statusline+=\ %{neomake#statusline#LoclistStatus('✗\ lc:\ ')}
set statusline+=\ %{neomake#statusline#QflistStatus('✗\ qf:\ ')}
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

" nerdtree: {{{2
let NERDChristmasTree=1
let NERDTreeWinSize=35
let NERDTreeDirArrows=1
let NERDTreeIgnore=['\.pyc$']
noremap <space>nc :NERDTreeCWD<CR>
noremap <space>nf :NERDTreeFind<CR>
noremap <silent> gon :NERDTreeToggle<CR>
noremap <space>no :NERDTree %:p:h<CR>
"}}}

" ultisnips: {{{2
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets="<c-h>"

"}}}

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
nnoremap <silent> [ctrlp]T :Tags<CR>
nnoremap <silent> [ctrlp]u :<C-u>CtrlPMRUFiles<cr>

let g:ctrlp_extensions = ['quickfix', 'buffertag', 'bookmarkdir']
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
    let g:ctrlp_use_caching = 1
endif

" ctrlp_buftag:
let g:ctrlp_buftag_types = {
    \ 'javascript'  : '--language-force=js',
    \ 'css'         : '--language-force=css',
    \ 'scss'        : '--language-force=css',
    \ 'gsp'         : '--language-force=XML',
    \ 'xml'         : '--language-force=XML',
    \ 'spring'      : '--language-force=XML',
    \ 'jsp'         : '--language-force=XML',
    \ 'html'        : '--language-force=XML',
    \ 'taskpaper'   : '--language-force=Taskpaper',
    \ 'wsdl'        : '--language-force=wsdl',
    \ 'markdown'    : '--language-force=markdown',
    \ 'text'        : '--language-force=markdown',
    \ 'cucumber'    : '--language-force=cucumber',
    \ 'sh'          : '--language-force=sh',
    \ 'dosini'      : '--language-force=ini'
    \ }

" }}} ctrlp/fzf

"ag: {{{2
" start search from project root
let g:ag_working_mode="r"
" workaround conflict with fzf.vim
command! -bang -nargs=* -complete=file -range AG call ag#Ag('grep<bang>',<q-args>)
nnoremap \\ :AG! <C-R><C-W><CR>
vnoremap \\ y<bar>:<C-U>AG! <C-R>"<CR>
"}}}

" neomake:{{{2
let g:neomake_open_list=0
let g:neomake_javascript_enabled_makers = ['jshint', 'jscs']
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_ruby_enabled_makers = ['rubocop']

let g:neomake_error_sign = {
        \ 'text': 'Х',
        \ 'texthl': 'ErrorMsg'
        \ }
let g:neomake_warning_sign = {
        \ 'text': '!≫',
        \ 'texthl': 'ErrorMsg'
        \ }

command! Rtags :NeomakeSh ctags -R
"}}}

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

function! GitDiffBuf()
    let fname = expand('%')
    new
    exec "r! git diff ".printf('%s', fname)
    :normal ggdd
    setlocal ft=diff bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction
nnoremap <space>gD :call GitDiffBuf()<CR>

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
nnoremap <space>gi :Gincoming<CR>

function! GitOutgoing()
    new
    r !git log --pretty=oneline --abbrev-commit --graph @{u}..
    setlocal ft=git bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction
command! Goutgoing :call GitOutgoing()
nnoremap <space>go :Goutgoing<CR>

command! Glast :Glog -n 5 --

function! GitTags()
    new
    r !git log --oneline --decorate --tags --no-walk
    :normal ggdd
    setlocal ft=git bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction
command! Gtags :call GitTags()

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
nnoremap ]gv :GitGutterPreviewHunk<CR>

nnoremap [gh :GitGutterStageHunk<CR>
nnoremap ]gh :GitGutterUndoHunk<CR>
"}}}

" emmet:
let g:user_emmet_expandabbr_key = '<C-e>'
let g:user_emmet_settings = {
            \ 'html' : {
            \    'indentation' : '  '
            \ },
            \}
" http-client:
let g:http_client_verify_ssl = 0
nnoremap [r :HTTPClientDoRequest<CR>
command! Rest :HTTPClientDoRequest

" indent guides
let g:indentLine_enabled = 0
nmap <space>ig :IndentLinesToggle<CR>

" dash:
if has("mac")
    nnoremap gK :Dash <C-r><C-w><space>
endif

" autocompletion:
let g:deoplete#enable_at_startup = g:nvim_autocompletion_enabled

function! ToggleComplete()
    if g:nvim_autocompletion_enabled == 1
        let g:nvim_autocompletion_enabled=0
        :silent call deoplete#disable()
    else
        let g:nvim_autocompletion_enabled=1
        :silent call deoplete#enable()
    endif

    echo 'auto-completion '.(g:nvim_autocompletion_enabled ? 'on' : 'off')
endfunction
nnoremap <silent> coa :call ToggleComplete()<CR>

" tagbar:
nnoremap cot :TagbarToggle<CR>
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Headings'
    \ ]
\ }

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

    augroup Cursorline
        autocmd!
        autocmd WinEnter    * set cursorline
        autocmd WinLeave    * set nocursorline
        autocmd InsertEnter * set nocursorline
        autocmd InsertLeave * set cursorline
    augroup END

    " remove trailing whitespace
    augroup StripWhitespace
        autocmd!
        autocmd! FileType vim,css,scss,groovy,java,javascript,less,php,scala,taskpaper,python,ruby,
                    \handlebars,html.handlebars,scheme autocmd BufWritePre <buffer> :%s/\s\+$//e
    augroup END

    augroup FTOptions
        autocmd!
        autocmd FileType cucumber setlocal shiftwidth=2 softtabstop=2 foldmethod=indent
        autocmd BufRead fugitive\:* xnoremap <buffer> dp :diffput<CR>|xnoremap <buffer> do :diffget<CR>
        autocmd BufNewFile,BufRead fugitive://* set bufhidden=delete
        autocmd FileType gitcommit setlocal cursorline spell
        autocmd FileType handlebars setlocal shiftwidth=2 softtabstop=2 foldmethod=manual
        autocmd FileType html.handlebars setlocal shiftwidth=2 softtabstop=2 foldmethod=manual
        autocmd FileType html,css,scss,javascript setlocal iskeyword+=-
        autocmd FileType html setlocal shiftwidth=2 softtabstop=2 tabstop=2 foldmethod=manual
        autocmd FileType html setlocal autoindent
        autocmd FileType scss setlocal shiftwidth=2 softtabstop=2 foldmethod=indent
        autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 foldmethod=indent
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType json command! Format :%!pretty-json<CR>
        autocmd FileType json setlocal foldmethod=syntax
        autocmd FileType json setlocal foldnestmax=10
        autocmd FileType json setlocal shiftwidth=2 softtabstop=2 foldmethod=indent
        autocmd FileType markdown  set shiftwidth=2 softtabstop=2 suffixesadd=.txt,.md
        autocmd Filetype php set shiftwidth=8 softtabstop=0 noexpandtab
        autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2 foldmethod=indent
        autocmd FileType scheme setlocal shiftwidth=2 softtabstop=2 foldmethod=indent
        autocmd Filetype vim set foldmethod=marker
        autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 foldmethod=indent
    augroup END

    augroup DiffMode
        autocmd FilterWritePre * if &diff | nnoremap <buffer> dc :Gdoff<CR> | nnoremap <buffer> du :diffupdate<CR> | endif
    augroup END
endif

" }}}

" Functions: {{{

function! DateTimeStamp()
    return strftime("%Y-%m-%d %H:%M")
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

" Taken from ctrlp help file
function! Setcwd()
    let cph = expand('%:p:h', 1)
    if cph =~ '^.\+://' | retu | en
    for mkr in ['.top', '.project', '.git/', '.hg/', '.svn/', '.vimprojects']
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

if filereadable(glob(g:nvim_abbrvs))
    exec 'source' g:nvim_abbrvs
endif

" }}}

" Local Configuration: {{{

if filereadable(glob(g:local_config))
    exec 'source' g:local_config
endif

" }}}
