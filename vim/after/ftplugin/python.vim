" Fichier de configuration de vim reservé au langage python
autocmd BufWinEnter *.py loadview
autocmd BufWinLeave,BufUnload *.py mkview
set foldenable
set foldmethod=indent
set foldnestmax=2

set viewoptions=folds,cursor
"autocmd BufWinEnter *.py loadview | set foldenable | set foldmethod=indent \
    "| set foldnestmax=2

" #########################################################
" # A way to delete 'mkview'
function! MyDeleteView()
	let path = fnamemodify(bufname('%'),':p')
	" vim's odd =~ escaping for /
	let path = substitute(path, '=', '==', 'g')
	if empty($HOME)
	else
		let path = substitute(path, '^'.$HOME, '\~', '')
	endif
	let path = substitute(path, '/', '=+', 'g') . '='
	" view directory
	let path = &viewdir.'/'.path
	call delete(path)
	echom "Deleted: ".path
endfunction
command! Delview call MyDeleteView()
" Lower-case user commands: http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev delview <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Delview' : 'delview')<CR>

"set viewoptions=folds
" This is used to save the folds before closing a file, and restoring them
" after opening (useful while reloading the file).
"autocmd BufRead * echom 'BufRead'
"autocmd BufHidden * echom 'BufHidden'
"autocmd BufWrite * echom 'BufWrite'
"autocmd BufLeave * echom 'BufLeave'
"autocmd BufWinLeave * echom 'BufWinLeave'
""autocmd BufUnload * mkview | echom 'mkview'
""autocmd BufWinEnter * silent loadview | echom 'loadview'
""autocmd BufWinEnter * echom 'BufWinEnter'
"autocmd BufWipeout * echom 'BufWipeout'
"autocmd BufFilePre * echom 'BufFilePre'
""autocmd BufUnload * echom 'BufUnload'
""autocmd BufHidden * echom 'BufHidden'
""autocmd BufNew * echom 'BufNew'
""autocmd BufDelete * Delview
""autocmd BufDelete * echom 'BufDelete'

" Execute file being edited with <Shift> + e:
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>
" Comment line
nnoremap <buffer> <LocalLeader>c I# <esc>
" Force un hard breaking de la ligne à 80 caractères
set textwidth=79
" Highlight lines over 79 characters.
highlight OverLength ctermbg=red
match OverLength /\%80v.\+/
nnoremap <buffer> <LocalLeader>mo :match OverLength /\%80v.\+/<cr>

" ROPE {{{
nnoremap <buffer> <LocalLeader>rn :RopeRename<cr>
vnoremap <buffer> <LocalLeader>rl :RopeExtractVariable<cr>
vnoremap <buffer> <LocalLeader>rm :RopeExtractMethod<cr>
nnoremap <buffer> <LocalLeader>ri :RopeInline<cr>
nnoremap <buffer> <LocalLeader>rv :RopeMove<cr>
nnoremap <buffer> <LocalLeader>rx :RopeRestructure<cr>
nnoremap <buffer> <LocalLeader>ru :RopeUseFunction<cr>
nnoremap <buffer> <LocalLeader>rs :RopeChangeSignature<cr>
" }}}

