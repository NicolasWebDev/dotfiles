" This is used to save the folds before closing a file, and restoring them
" after opening (useful while reloading the file).
autocmd BufWinEnter *.rb loadview
autocmd BufWinLeave,BufUnload *.rb mkview
setlocal foldenable
setlocal foldmethod=indent
setlocal foldnestmax=2

setlocal viewoptions=folds,cursor

setlocal textwidth=80
setlocal formatoptions+=t
" Highlight lines over 80 characters.
let &l:colorcolumn=join(range(81,999),",")

setlocal softtabstop=4
setlocal shiftwidth=4
setlocal tabstop=4
