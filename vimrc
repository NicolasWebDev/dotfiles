source ~/.vimrc_bepo " remappage des touches de navigation pour le bépo

" BASIC SETTINGS {{{
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

    " To change buffer rapidly
    nnoremap <leader>n :bn<cr>
    nnoremap <leader>p :bp<cr>

    " Set a timeout on the mappings lower than the default 1s (500ms here)
    set ttimeout
    set ttimeoutlen=500

    set omnifunc=syntaxcomplete#Complete
    " Remap control space to the omni-completion.
    inoremap <C-@> <C-x><C-o>

    " Source a global configuration file if available
    " XXX Deprecated, please move your changes here in /etc/vim/vimrc
    "if filereadable("/etc/vim/vimrc.local")
    "  source /etc/vim/vimrc.local
    "endif

    " travailler avec de l'unicode par défaut (utf-8)
    if has("multi_byte")
      if &termencoding == ""
        let &termencoding = &encoding
      endif
      set encoding=utf-8
      set fileencoding=utf-8
    " bomb adds special characters which poses problems later
    "  set bomb
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

    " Montrer les commandes en cours dans la ligne de statut
    set showcmd

    " Quand le curseur est positionné sur une parenthèse, crochet, accolade, etc.,
    " mettre en surbrillance la parenthèse (etc.) correspondante
    set showmatch

    " while typing a search command, show immediately where the so far typed
    " pattern matches
    set incsearch

    " wraps long lines visually
    set wrap
    " wraps around words, doesn't break a word in the middle
    set linebreak

    " when there is a previous search pattern, highlight all its matches
    set hlsearch

    " Sauver automatiquement le buffer d'édition avant les commandes du type :next
    " ou :make
    set autowrite

    set backspace=indent,eol,start

    " Toggle line numbers and fold column for easy copying:
    nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

    " Open found file in a vertical split.
    cnoremap vfind vertical sfind 

    " text indenting
    set autoindent

    if has("gui_running")
        " I find the toolbar in the GUI version of vim (gvim) to be somewhat useless visual clutter. This option gets rid of the toolbar.
        set guioptions-=T
        colorscheme slate
        set guifont=Monospace\ 10  " use this font
        " highlight cursor line (must come after colorscheme command to take effect)
        set cursorline
        highlight CursorLine guibg=#001000
    endif

    " change default color scheme
    colorscheme perso

    " highlight cursor line (must come after colorscheme command to take effect)
    set cursorline
    set cursorcolumn

    " change the color of the search occurences
    "hi Search cterm=NONE ctermbg=136 ctermfg=blue

    set nocompatible        " Utilise les défauts Vim (bien mieux !)

    " show the line and column number of the cursor position, separated by a
    " comma
    set ruler

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
    set softtabstop=4   " how many columns vim uses when you hit Tab in insert mode

    set shiftwidth=4	" largeur de l'indentation

    set tabstop=4       " numbers of spaces of tab character. A garder toujours a 8 selon le man de vim afin de ne pas tout deformer entre autre a l'impression.

    " Characters leading wrapped lines.
    set showbreak=+++

    " replace tab with spaces
    set expandtab

    " <----------------------------

    set title           " show title in console title bar

    noremap <leader>qq :bd<cr>
    noremap <leader>qQ :Bdelete<cr>

    set hidden             " Hide buffers when they are abandoned

    let xml_tag_completion_map = "»"

    set mouse=a		" Enable mouse usage (all modes) in terminals
" }}}

" HTML FILE SETTINGS {{{
augroup filetype_html
    autocmd!
    " commande pour mettre les .html en UTF-8
    autocmd FileType html set fileencoding=utf-8
    autocmd FileType html set bomb
    " commandes pour le html
    autocmd FileType html map <F3> :!firefox % >/dev/null 2>&1 &<CR><CR>
augroup END
" }}}

" ADDONS SETTINGS {{{

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

" PATHOGEN {{{
execute pathogen#infect()
" }}}

" SYNTASTIC {{{
let g:syntastic_python_pylint_post_args = "--rcfile=../.pylintrc"
let g:syntastic_mode_map = {'mode': 'active'}
" }}}

" ULTISNIPS {{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<c-b>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:ultisnips_python_style="sphinx"
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

" ODOO SETTINGS {{{
    iabbrev iv8 import openerp as v8
    nnoremap <leader>of :call MigrateNormalField()<cr>
    iabbrev #f #---FIELDS FUNCTIONS
    iabbrev #d #---DEFINITION
    iabbrev #v #---PRIVATE FUNCTIONS
    iabbrev #p #---PUBLIC FUNCTIONS
    iabbrev #o #---OVERWRITE
    iabbrev #a #---ACTIONS
    iabbrev #e #---EVENTS
    iabbrev #c #---CONSTRAINTS
    iabbrev #s #---SELECTION FUNCTIONS
    func! Eatchar(pat)
      let c = nr2char(getchar(0))
      return (c =~ a:pat) ? '' : c
    endfunc
    iabbrev ato @api.one
    iabbrev atd @api.depends('')<Left><Left><C-R>=Eatchar('\s')<CR>
    iabbrev atc @api.constrains('')<Left><Left><C-R>=Eatchar('\s')<CR>
    iabbrev atm @api.multi
    iabbrev atl @api.model
    iabbrev atr @api.returns('')<Left><Left><C-R>=Eatchar('\s')<CR>
" }}}
