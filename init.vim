" Variables: {{{

let g:nvim_config = "~/.config/nvim/"
let g:nvim_site_config = "~/.local/share/nvim/site/plugin/"
let g:local_data = "~/.local/share/data/"
let g:nvimrc = g:nvim_config . "init.vim"
let g:site_nvimrc = g:nvim_site_config . "site.vim"
let g:nvim_bundle=g:nvim_config.'bundle'
let g:nvim_autocompletion_enabled = 0
let g:nvim_config_use_relinsert = 1
let g:jira_browse = ""
let g:nvim_scratch_file = g:local_data . 'scratch.txt'

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

Plug 'w0rp/ale'

Plug 'SirVer/ultisnips'

Plug 'jeetsukumaran/vim-filebeagle'

Plug 'scrooloose/nerdtree'

Plug 'mileszs/ack.vim'

Plug 'pangloss/vim-javascript'

Plug 'mustache/vim-mustache-handlebars'

Plug 'tpope/vim-markdown'

Plug 'rodjek/vim-puppet'

Plug 'mattn/emmet-vim'

Plug 'tpope/vim-projectionist'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf.vim'

Plug 'dyng/ctrlsf.vim'

Plug 'junegunn/gv.vim'

Plug 'Yggdroot/indentLine'

Plug 'jiangmiao/auto-pairs'

Plug 'mmazer/vim-http-client'

Plug 'qpkorr/vim-bufkill'

function! UpdateRemote(arg)
    UpdateRemotePlugins
endfunction

Plug 'Shougo/deoplete.nvim', { 'do': function('UpdateRemote') }

if has("mac")
    Plug 'rizzatti/dash.vim'
endif

Plug 'ajh17/Spacegray.vim'

Plug 'davidhalter/jedi-vim'

Plug 'vim-ruby/vim-ruby'

Plug 'majutsushi/tagbar'

Plug 'kassio/neoterm'

Plug 'AndrewRadev/simple_bookmarks.vim'

Plug 'tpope/vim-dispatch'

Plug 'radenling/vim-dispatch-neovim'

call plug#end()

" }}}

" Basics: {{{

filetype plugin indent on
set shell=/usr/local/bin/bash\ -O\ globstar

"}}}

" Moving: {{{

" Better mark jumping (line + col)
nnoremap <expr> ' printf('`%c zz', getchar())

nnoremap \c "+y
vnoremap \c "+y
nnoremap \v "+p

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
nnoremap gh ^
noremap L $
nnoremap gl $
vnoremap L g_

" move to middle of text line
nnoremap gm :call cursor(0, virtcol('$')/2)<CR>

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

if executable('rg')
    set grepprg=rg\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
    set grepformat=%f:%l:%c:%m
    let g:ackprg = 'rg --vimgrep'
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

" slightly easier to reach than <C-w>
inoremap <C-d> <C-w>

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

if exists('&inccommand')
  set inccommand=split
endif

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

" show full path of file
nnoremap <space>p :echo expand('%')<CR>

nnoremap <silent> goh :lcd ~<CR>
nnoremap gov :exec 'edit' g:nvimrc <CR>
nnoremap gol :exec 'edit' g:site_nvimrc <CR>
nnoremap gos :exec 'edit' g:nvim_scratch_file<CR>

" }}}

" Windows and buffers: {{{

set title

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

nnoremap <C-<>     :tabfirst<CR>
nnoremap <C-right> :tabnext<CR>
nnoremap <C-left>  :tabprev<CR>
nnoremap td        :tabclose<CR>

"}}}

" Colors: {{{

set termguicolors
colorscheme space

" }}}

" Command Line: {{{

nmap <space><space> :
nmap <space>h :h<space>
nnoremap <silent> Q :qa!<CR>
" For quick one line expressions
nnoremap <space>x :<C-R>=

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
noremap <space>nb :NERDTreeFromBookmark<SPACE>
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

" fzf: {{{2
let g:fzf_tags_command = 'ctags --extra=+f -R'

nmap <space> [fzf]
nnoremap <silent> [fzf]a :Ag<CR>
nnoremap <silent> [fzf]b :Buffers<cr>
nnoremap <silent> [fzf]c :History:<CR>
nnoremap <silent> [fzf]C :BCommits<CR>
nnoremap <silent> [fzf]f :Files<CR>
nnoremap <silent> [fzf]g :GitFiles<CR>
nnoremap <silent> [fzf]l :Lines<CR>
nnoremap <silent> [fzf]m :Marks<CR>
nnoremap <silent> [fzf]s :BLines<CR>
nnoremap <silent> [fzf]t :BTags<cr>
nnoremap <silent> [fzf]T :Tags<CR>
nnoremap <silent> [fzf]u :History<CR>

"}}} fzf

"ack: {{{2
nnoremap \\ :Ack! <C-R><C-W><CR>
vnoremap \\ y<bar>:<C-U>Ack! <C-R>"<CR>
nnoremap <space>/ :Ack!<space>
"}}}

" ctrlsf: {{{2
let g:ctrlsf_ackprg = '/usr/local/bin/rg'
nmap <C-S> [ctrlsf]
nmap     [ctrlsf]f <Plug>CtrlSFPrompt
vmap     [ctrlsf]f <Plug>CtrlSFVwordPath
vmap     [ctrlsf]F <Plug>CtrlSFVwordExec
nmap     [ctrlsf]n <Plug>CtrlSFCwordPath
nmap     [ctrlsf]p <Plug>CtrlSFPwordPath
nnoremap [ctrlsf]o :CtrlSFOpen<CR>
nnoremap [ctrlsf]t :CtrlSFToggle<CR>
inoremap [ctrlsf]t <Esc>:CtrlSFToggle<CR>
nmap     [ctrlsf]l <Plug>CtrlSFQuickfixPrompt
vmap     [ctrlsf]l <Plug>CtrlSFQuickfixVwordPath
vmap     [ctrlsf]L <Plug>CtrlSFQuickfixVwordExec

" }}}

" ale: {{{2
let g:ale_linters = {
    \   'javascript':   ['eslint'],
    \   'ruby':         ['rubocop'],
    \   'python':       ['flake8']
        \ }

let g:ale_statusline_format = ['E:%d', 'W:%d', '✓']
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
nmap <silent> <]e> <Plug>(ale_next_wrap)
nmap <silent> <[e> <Plug>(ale_previous_wrap)

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
let g:http_client_preserve_responses = 1
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

" neoterm: {{{2
" use half of current window for neoterm
let g:neoterm_size=''
nnoremap <silent> tv :Tpos vertical<CR>
nnoremap <silent> th :Tpos horizontal<CR>
nnoremap <silent> tn :Tnew<CR>
nnoremap <silent> to :Topen<CR>
nnoremap <silent> tc :Tclose<CR>
nnoremap <silent> tl :TREPLSendLine<CR>
vnoremap <silent> tl :TREPLSendSelection<CR>
nnoremap tt :T<space>

" general terminal bindings
tnoremap <C-x> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" }}}

" jedi: {{{2
let g:jedi#force_py_version = 3
" }}}

" simple_bookmarks: {{{2
let g:simple_bookmarks_filename = g:local_data . 'vim_bookmarks'
"}}}

" }}} Plugin Settings

" AutoGroups: {{{

if has("autocmd")

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
                    \handlebars,html.handlebars,scheme,yaml autocmd BufWritePre <buffer> :%s/\s\+$//e
    augroup END

    augroup FTOptions
        autocmd!
        autocmd BufRead fugitive\:* xnoremap <buffer> dp :diffput<CR>|xnoremap <buffer> do :diffget<CR>
        autocmd BufNewFile,BufRead fugitive://* set bufhidden=delete
        autocmd FileType html.handlebars setlocal shiftwidth=2 softtabstop=2 foldmethod=manual
    augroup END

    augroup DiffMode
        autocmd FilterWritePre * if &diff | nnoremap <buffer> dc :Gdoff<CR> | nnoremap <buffer> du :diffupdate<CR> | endif
    augroup END

    augroup Checktime
        autocmd CursorHold * checktime
        autocmd BufWinEnter * checktime
    augroup END
endif

" }}}

" Tags: {{{2
nnoremap T :Dispatch! ctags --extra+=f -R<CR>
"}}}

