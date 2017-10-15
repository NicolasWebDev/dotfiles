highlight Other ctermfg=brown cterm=bold
call matchadd('Other', '^\$\(\d\{2}:\d\{2}_\)\?\S*$')

highlight ProtelDone ctermfg=red cterm=underline,bold
call matchadd('ProtelDone', '^\$\(\d\{2}:\d\{2}_\)\?protel\$$')

highlight Protel ctermfg=red cterm=bold
call matchadd('Protel', '^\$\(\d\{2}:\d\{2}_\)\?protel$')

highlight SelectaDone ctermfg=green cterm=underline,bold
call matchadd('SelectaDone', '^\$\(\d\{2}:\d\{2}_\)\?selecta\$$')

highlight Selecta ctermfg=green cterm=bold
call matchadd('Selecta', '^\$\(\d\{2}:\d\{2}_\)\?selecta$')

