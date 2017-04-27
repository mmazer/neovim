let g:ctrlsf_ackprg = '/usr/local/bin/rg'
let g:ctrlsf_auto_close=0
let g:ctrlsf_mapping = {
    \ "open" : ["<CR>"],
    \ "vsplit" : "o"
\ }

nmap <C-S> [ctrlsf]
nmap     [ctrlsf]f :CtrlSF -L<space>
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
