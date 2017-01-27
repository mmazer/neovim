function! OpenURI()
    " 2011-01-21 removed colon ':' from regexp to allow for port numbers in URLs
    " original regexp: [a-z]*:\/\/[^ >,;:]*
    let uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;\)\"]*')
    if uri != ""
        let uri = escape(uri, "#%; ")
        echo uri

        if has('win32')
            exec ":silent !cmd /C start /min " . uri
        elseif has('mac')
            exec ":silent !open \"" . printf("%s", uri) . "\""
        elseif has('unix')
            exec ":silent !firefox \"" . printf("%s", uri) . "\""
        else
            echo "OpenURI not supported on this system"
        endif
        exec ":redraw!"
    else
        echo "No URI found in line."
    endif
endfunction
noremap gou :call OpenURI()<CR>
