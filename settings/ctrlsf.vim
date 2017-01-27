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
