let g:ale_linters = {
    \   'javascript':   ['eslint'],
    \   'ruby':         ['rubocop'],
    \   'python':       ['flake8']
    \}

let g:ale_statusline_format = ['E:%d', 'W:%d', '✓']
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '∆'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

nmap <silent> <]e> <Plug>(ale_next_wrap)
nmap <silent> <[e> <Plug>(ale_previous_wrap)
