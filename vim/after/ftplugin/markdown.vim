command! -buffer Date execute 'normal i' . system("date -I") | :startinsert! | :normal i==========<Enter><Enter>##  <Esc>
