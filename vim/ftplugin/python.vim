" Fichier de configuration de vim reservé au langage python
"
set foldmethod=indent
set nofoldenable
set foldnestmax=2

" Execute file being edited with <Shift> + e:
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>

" Commande pour lancer Pyflakes afin de trouver des erreurs de syntaxe dans le
" code
command! Pyflakes :call Pyflakes()
function! Pyflakes()
    let tmpfile = tempname()
    execute "w" tmpfile
    execute "set makeprg=(pyflakes\\ " . tmpfile . "\\\\\\|sed\\ s@" . tmpfile ."@%@)"
    make
    cw
endfunction

" Commande pour lancer Pylint afin de trouver des erreurs de syntaxe dans le
" code
command! Pylint :call Pylint()
function! Pylint()
    setlocal makeprg=(echo\ '[%]';\ pylint\ %)
    setlocal efm=%+P[%f],%t:\ %#%l:%m
    silent make
    cwindow
endfunction
