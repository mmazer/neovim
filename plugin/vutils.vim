if exists("g:loaded_vutils")
  finish
endif

let g:loaded_vutils = 1

command! Syntax :echo vutils#syntax()

command! CdRootDir :silent call vutils#cd_rootdir()

nnoremap gto :CdRootDir<CR>:pwd<CR>
nnoremap coe :call vutils#toggle_et()<CR>

