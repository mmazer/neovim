let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = g:nvim_autocompletion_enabled ? 0 : 1

if has("gui_running") || has("gui_vimr")
    inoremap <silent><expr><C-Space> deoplete#mappings#manual_complete()
else
    inoremap <silent><expr><C-@> deoplete#mappings#manual_complete()
endif

