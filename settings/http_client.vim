let g:http_client_verify_ssl = 0
let g:http_client_preserve_responses = 1

nnoremap [r :HTTPClientDoRequest<CR>
command! Rest :HTTPClientDoRequest
