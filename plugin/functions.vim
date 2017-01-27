function! SyntaxItem()
    return synIDattr(synID(line("."),col("."),1),"name")
endfunction
command! Syntax :echo SyntaxItem()
nnoremap <leader>s :Syntax<CR>

" Taken from ctrlp help file
function! SetCwd()
    let cph = expand('%:p:h', 1)
    if cph =~ '^.\+://' | retu | en
    for mkr in ['.top', '.project', '.git/', '.hg/', '.svn/', '.vimprojects']
        let wd = call('find'.(mkr =~ '/$' ? 'dir' : 'file'), [mkr, cph.';'])
        if wd != '' | let &acd = 0 | brea | en
    endfo
    exe 'lc!' fnameescape(wd == '' ? cph : substitute(wd, mkr.'$', '.', ''))
endfunction
command! SetCwd :silent call SetCwd()
nnoremap gop :SetCwd<CR>:pwd<CR>

function! Calendar()
    new
    :normal gg
    :put =strftime('%c')
    :normal o
    r !cal
    setlocal bt=nofile bh=wipe nobl noswf ro
    nnoremap <buffer> q :bw<cr>
endfunction
command! Cal :call Calendar()
nnoremap goc :Cal<CR>
