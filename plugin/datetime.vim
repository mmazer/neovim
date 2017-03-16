if exists("g:loaded_datetime")
  finish
endif
let g:loaded_datetime = 1

command! Date :call datetime#date()

command! -nargs=? Cal :call datetime#cal('<args>')

nnoremap goc :Cal<CR>

iab dts <c-r>=datetime#datetime()<esc>
iab ddt <c-r>=datetime#short_date()<esc>
