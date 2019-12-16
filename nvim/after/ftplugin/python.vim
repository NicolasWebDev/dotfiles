" Fichier de configuration de vim reservé au langage python

" This is used to save the folds before closing a file, and restoring them
" after opening (useful while reloading the file).
autocmd BufWinEnter *.py loadview
autocmd BufWinLeave,BufUnload *.py mkview

setlocal viewoptions=folds,cursor

" Force un hard breaking de la ligne à 80 caractères
setlocal textwidth=79
" Highlight lines over 79 characters.
let &l:colorcolumn=join(range(80,999),",")

" ROPE {{{
" To enable the opening of a project, in the directory containing the
" currently edited file.
let g:ropevim_guess_project=1
nnoremap <buffer> <LocalLeader>rn :RopeRename<cr>
vnoremap <buffer> <LocalLeader>rl :RopeExtractVariable<cr>
vnoremap <buffer> <LocalLeader>rm :RopeExtractMethod<cr>
nnoremap <buffer> <LocalLeader>ri :RopeInline<cr>
nnoremap <buffer> <LocalLeader>rv :RopeMove<cr>
nnoremap <buffer> <LocalLeader>rx :RopeRestructure<cr>
nnoremap <buffer> <LocalLeader>ru :RopeUseFunction<cr>
nnoremap <buffer> <LocalLeader>rs :RopeChangeSignature<cr>
" }}}

