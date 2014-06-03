function! CheckoutCurrentFile()
    let filename = expand("%:p")
    if (match(filename, "/vob/") != -1)
        execute "!/usr/cisco/bin/cc_co -nc -f " . filename
        redraw!
        edit!
        set noreadonly
    endif
endfunction

augroup cleartool
    au!
    autocmd FileChangedRO * call CheckoutCurrentFile()
augroup END
