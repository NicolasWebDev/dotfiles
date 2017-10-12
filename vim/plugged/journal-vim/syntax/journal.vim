" Build upon Markdown syntax
" runtime! syntax/markdown.vim

unlet! b:current_syntax

syntax  match  Pomodoro 'pomodoro'

" Other priority colours might be defined by the user
highlight  default  Pomodoro       ctermbg=red

let b:current_syntax='journal'
