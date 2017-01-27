set nocompatible
set number
set scrolloff=999
set wildmenu
set wildmode=list:longest
set shortmess=aTIoO
set laststatus=2

filetype plugin indent on
syntax on

" basic mappings
nnoremap <silent> Q :qa!<CR>

set laststatus=2
set statusline+=\ %f
set statusline+=%(\ %R%M%)      "modified flag
set statusline+=%{&paste?'\ [paste]':''}
set statusline+=%=
set statusline+=\ %y      "filetype
set statusline+=\ %{&ff}  "file format
set statusline+=\ %{&expandtab?'spaces':'tabs'}
set statusline+=\ %5.l/%L\:%-3.c\    "cursor line/total lines:column
set statusline+=\ #%n

