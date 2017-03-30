" Variables: {{{
let g:xdg_config_home             = $XDG_CONFIG_HOME
let g:xdg_data_home               = $XDG_DATA_HOME
let g:nvim_config_home            = g:xdg_config_home . '/nvim'
let g:nvim_site_config_home       = g:xdg_data_home . '/nvim/site/plugin'
let g:nvimrc                      = g:nvim_config_home . '/init.vim'
let g:site_nvimrc                 = g:nvim_site_config_home . '/site.vim'
let g:nvim_bundle_home            = g:nvim_config_home . '/bundle'
let g:nvim_config_use_relinsert   = 0
let g:jira_browse                 = ''
let g:nvim_scratch_file           = g:xdg_data_home.'/nvim/scratch.txt'
" Show current tag in statusline - can be be toggled with :ToggleCurrentTag
let g:nvim_show_current_tag       = 0
let g:nvim_autocompletion_enabled = 0
" }}}

" Important: {{{

let g:python_host_skip_check  = 1
let g:python3_host_skip_check = 1

" No need to load this and we save some start up time
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
" }}}

" Loading Plugins: {{{

call plug#begin(g:nvim_bundle_home)

Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-unimpaired'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-cucumber'

Plug 'w0rp/ale'

Plug 'SirVer/ultisnips'

Plug 'mileszs/ack.vim'

Plug 'pangloss/vim-javascript'

Plug 'mustache/vim-mustache-handlebars'

Plug 'rodjek/vim-puppet'

Plug 'mattn/emmet-vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf.vim'

Plug 'dyng/ctrlsf.vim'

Plug 'jiangmiao/auto-pairs'

Plug 'ajh17/Spacegray.vim'

Plug 'davidhalter/jedi-vim'

Plug 'vim-ruby/vim-ruby'

Plug 'majutsushi/tagbar'

Plug 'kassio/neoterm'

Plug 'tpope/vim-dispatch'

Plug 'radenling/vim-dispatch-neovim'

Plug 'ap/vim-buftabline'

Plug 'justinmk/vim-dirvish'

Plug 'junegunn/vim-easy-align'

function! UpdateRemote(arg)
    UpdateRemotePlugins
endfunction

Plug 'Shougo/deoplete.nvim', { 'do': function('UpdateRemote') }

call plug#end()

" }}}

" Basics: {{{

filetype plugin indent on
set exrc
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

command! Strip :call vutils#preserve("%s/\\s\\+$//e")
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
inoremap ;] <C-\><C-O>:call vutils#preserve("s/\\s\*$/;/")<CR>
nnoremap <space>; :call vutils#preserve("s/\\s\*$/;/")<CR>

" end lines with commas
inoremap ,] <C-\><C-O>:call vutils#preserve("s/\\s\*$/,/")<CR>
nnoremap <space>, :call vutils#preserve("s/\\s\*$/,/")<CR>

" toggle case of words
nnoremap [w gUiw
nnoremap ]w guiw

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

" Allow saving of files as sudo
if executable('sudo')
    cmap w!! w !sudo tee > /dev/null %
endif

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

nnoremap <space>B :b#<CR>
nnoremap <space>d :bp \| bd #<CR>
nnoremap <space>D :BD<CR> " use buffkil

" goto buffer
nnoremap gob :ls<CR>:b

nnoremap goe :enew<CR>

" close quick fix and location list
nnoremap qq :cclose<CR>
nnoremap ql :lclose<CR>
nnoremap qp :pclose<CR>

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
nnoremap <silent> Q :qa!<CR>
" For quick one line expressions
nnoremap <space>x :<C-R>=

" }}}

" Spelling: {{{

set spelllang=en
let &spellfile=g:nvim_config_home . '/spell/spellfile.en.add'

"}}}

" Tags: {{{2
nnoremap <leader>T :Dispatch! ctags --extra=+f -R<CR>
"}}}

" === Settings ===
runtime! settings/*.vim
