source ~/.vimrc_bepo " remappage des touches de navigation pour le bépo

" BASIC SETTINGS {{{
    " to make the mouse work inside of tmux.
    set ttymouse=xterm2
    set relativenumber
    set number
    set numberwidth=1

    " Add the current directory to the path recursively. Usefull to make
    " find/sfind work.
    set path=$PWD/**

    " Delete all existing views when exiting vim.
    autocmd VimLeave * execute "!rm ".&viewdir."/*"

    " Uncomment the following to have Vim load indentation rules according to the
    " detected filetype. Per default Debian Vim only load filetype specific
    " plugins.
    if has("autocmd")
        filetype plugin indent on
    endif

    set listchars+=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

    let maplocalleader="-"

    " Set a timeout on the mappings lower than the default 1s (500ms here)
    set ttimeout
    set ttimeoutlen=500

    set omnifunc=syntaxcomplete#Complete
    " Remap control space to the omni-completion.
    inoremap <C-@> <C-x><C-o>

    " work with unicode by default (utf-8)
    if has("multi_byte")
      if &termencoding == ""
        let &termencoding = &encoding
      endif
      set encoding=utf-8
      set fileencoding=utf-8
    " bomb adds special characters which poses problems later
    " set bomb
      setglobal fileencoding=utf-8
    "  setglobal bomb
    "  set fileencodings=ucs-bom,utf-8,latin1
    endif

    " line needed to use vim as pager to read the man-pages
    let $PAGER=''

    " enable syntax highlightning
    syntax on

    " number of commands saved in the history
    set history=1000

    " ignore case in searches
    set ignorecase
    " without case when search pattern contains only lowercase. works only when
    " ignorecase is set
    set smartcase

    " while typing a search command, show immediately where the so far typed
    " pattern matches
    set incsearch

    " wraps long lines visually
    set wrap
    " wraps around words, doesn't break a word in the middle
    set linebreak

    " when there is a previous search pattern, highlight all its matches
    set hlsearch

    " Save automatically the edition buffer before the commands :next or make
    set autowrite

    set backspace=indent,eol,start

    " Toggle line numbers and fold column for easy copying:
    nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

    " Open found file in a vertical split.
    cnoremap vfind vertical sfind 

    " text indenting
    set autoindent

    " change default color scheme
    colorscheme perso

    " highlight cursor line (must come after colorscheme command to take effect)
    set cursorline
    set cursorcolumn

    " Make the command-line completion work like bash, additionaly let choose the
    " option after third tab.
    set wildmenu
    set wildmode=longest,list,full

    " Let always one line above/below the cursor.
    if !&scrolloff
        set scrolloff=1
    endif

    set display+=lastline

    " INDENTATION ET TABULATIONS
    " A cet effet lire entre autre ce site : http://tedlogan.com/techblog3.html
    "
    " how many columns vim uses when you hit Tab in insert mode
    set softtabstop=4

    " indentation width
    set shiftwidth=4

    " numbers of spaces of tab character.
    set tabstop=4

    " Characters leading wrapped lines.
    set showbreak=+

    " replace tab with spaces
    set expandtab

    " <----------------------------
    " show title in console title bar
    set title

    noremap <leader>qq :bd<cr>
    noremap <leader>qQ :Bdelete<cr>

    " Hide buffers when they are abandoned.
    set hidden

    set mouse=a		" Enable mouse usage (all modes) in terminals
" }}}

" ODOO SETTINGS {{{
" Let copy/paste definitions of fields in the view, and change one line to a
" field.
noremap <leader>of I<field name="<esc>ea" /><esc>ld$j
" }}}

" HTML FILE SETTINGS {{{
augroup filetype_html
    autocmd!
    " commandes pour le html
    autocmd FileType html map <F3> :!firefox % >/dev/null 2>&1 &<CR><CR>
augroup END
" }}}

" ADDONS SETTINGS {{{

" VIM-PLUG {{{
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdcommenter'
Plug 'python-rope/ropevim'
Plug 'ervandew/supertab'
Plug 'scrooloose/syntastic'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-bundler'
Plug 'kchmck/vim-coffee-script'
Plug 'dkprice/vim-easygrep'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-rails'
Plug 'slim-template/vim-slim'
Plug 'honza/vim-snippets'
Plug 'sukima/xmledit'
Plug 'Valloric/YouCompleteMe'
call plug#end()
" }}}

" TAGLIST {{{
set updatetime=1000
" }}}

" AIRLINE {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_detect_whitespace = 0
let g:airline_section_warning = ''
let g:airline_section_x = '%{airline#extensions#tagbar#currenttag()}'
let g:Powerline_symbols = 'fancy'
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
" vim-powerline symbols
let g:airline_left_sep          = '⮀'
let g:airline_left_alt_sep      = '⮁'
let g:airline_right_sep         = '⮂'
let g:airline_right_alt_sep     = '⮃'
let g:airline_branch_prefix     = '⭠'
let g:airline_readonly_symbol   = '⭤'
let g:airline_linecolumn_prefix = '⭡'
" }}}

" VCSCOMMAND {{{
" This enables to open a directory using :e dir/path with netrw, and then
" use VCSCommands on it.
let NERDTreeHijackNetrw = 0
" }}}

" EASYGREP {{{
let EasyGrepRecursive = 1
let EasyGrepDefaultUserPattern = "*.py *.xml"
let EasyGrepMode = 3
" }}}

" NERDTREE SETTINGS {{{
noremap <leader>n :NERDTreeToggle<cr>
" }}}

" SYNTASTIC {{{
let g:syntastic_aggregate_errors = 1
let g:syntastic_python_pylint_post_args = "--rcfile=../.pylintrc"
let g:syntastic_ruby_checkers = ["mri", "rubocop", "reek"]
let g:syntastic_scss_checkers = ["scss", "stylelint"]
let g:syntastic_javascript_checkers = ["eslint"]
let g:syntastic_mode_map = {'mode': 'active'}
" }}}

" YOUCOMPLETEME {{{
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-t>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-s>', '<Down>']
let g:SuperTabDefaultCompletionType = '<C-t>'
" }}}

" ULTISNIPS {{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsListSnippets="<c-b>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:ultisnips_python_style="sphinx"
" }}}

" XML-EDIT {{{
let xml_tag_completion_map = "»"
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
au FileType xml setlocal foldnestmax=3
" }}}

" VIM-MARKDOWN {{{
" Make folding nicer, showing the second level folded, with the header as a
" title of the folds.
let g:vim_markdown_folding_style_pythonic = 1
set conceallevel=2
" }}}
" }}}

" LEARN VIM THE HARD WAY {{{
nnoremap <leader>- ddp
nnoremap <leader>_ ddkP
inoremap <leader><c-u> <esc>viwUi
nnoremap <leader><c-u> viwU
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
iabbrev fs self, cr, uid, ids, context=None):<cr>
iabbrev fc cr, uid, ids, context=context)<cr>
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
vnoremap <leader>' <esc>`<i'<esc>`>a'<esc>
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>
nnoremap <leader>bp :execute "aboveleft split " . bufname("#")<cr>
nnoremap <leader>w :execute "match Error " . '/\s\+$/'<cr>
nnoremap <leader>W :execute "match none"<cr>
nnoremap / /\v
nnoremap ? ?\v
nnoremap <leader>hs :set nohlsearch<cr>
"nnoremap <leader>g :silent! execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>
nnoremap <leader>qn :cnext<cr>
nnoremap <leader>qp :cprevious<cr>

" Javascript file settings {{{
augroup filetype_javascript
    autocmd!
    autocmd FileType javascript nnoremap <buffer> <LocalLeader>c I// <esc>
augroup END
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
" }}}

" Markdown file settings {{{
augroup filetype_markdown
    autocmd!
    autocmd FileType markdown onoremap <buffer> <leader>ih :<c-u>execute "normal! ?^[-=]\\{2,}$\r:nohlsearch\rkvg_"<cr>
    autocmd FileType markdown onoremap <buffer> <leader>ah :<c-u>execute "normal! ?^[-=]\\{2,}$\r:nohlsearch\rg_vk0"<cr>
augroup END
" }}}

" Vimscript file settings {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" }}}
