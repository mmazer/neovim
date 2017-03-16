if exists("g:autoloaded_openuri")
  finish
endif

let g:autoloaded_openuri = 1

function! openuri#inline()
    let uri = shellescape(matchstr(getline("."), '[a-z]*:\/\/[^ >,;\)\"]*'), 1)
    if uri != ""
        echo uri

        if has('win32')
            silent exec "!cmd /C start /min ".uri
        elseif has('mac')
            silent exec "!open ".uri
        elseif has('unix')
            silent "!firefox ".uri
        else
            echo "OpenURI not supported on this system"
        endif
        exec ":redraw!"
    else
        echo "No URI found in line."
    endif
endfunction
