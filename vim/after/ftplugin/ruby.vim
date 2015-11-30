" Fichier de configuration de vim reservé au langage python

" This is used to save the folds before closing a file, and restoring them
" after opening (useful while reloading the file).
autocmd BufWinEnter *.rb loadview
autocmd BufWinLeave,BufUnload *.rb mkview
setlocal foldenable
setlocal foldmethod=indent
setlocal foldnestmax=2

setlocal viewoptions=folds,cursor

" Comment line
nnoremap <buffer> <LocalLeader>c I# <esc>
" Force un hard breaking de la ligne à 80 caractères
set textwidth=79
" Highlight lines over 79 characters.
highlight OverLength ctermbg=red
match OverLength /\%80v.\+/
nnoremap <buffer> <LocalLeader>mo :match OverLength /\%80v.\+/<cr>

set softtabstop=2
set shiftwidth=2
set tabstop=2
