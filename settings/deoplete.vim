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
