" TODO
" - remove all french comments
" - put mappings together
" - put the bepo mappings here
" - resolve linting errors

source ~/.vimrc_bepo " remappage des touches de navigation pour le bépo

" VIM-PLUG {{{
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'morhetz/gruvbox'
Plug 'felixhummel/setcolors.vim'
Plug 'tpope/vim-abolish'
Plug 'moll/vim-node'
Plug 'chrisbra/csv.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'scrooloose/nerdcommenter'
Plug 'python-rope/ropevim'
Plug 'ervandew/supertab'
Plug 'scrooloose/syntastic'
Plug 'syngan/vim-vimlint' | Plug 'ynkdir/vim-vimlparser'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-line'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'dkprice/vim-easygrep'
Plug 'plasticboy/vim-markdown'
Plug 'slim-template/vim-slim'
Plug 'sukima/xmledit'
Plug 'tmhedberg/matchit'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
Plug 'tmhedberg/matchit'
Plug 'Sathors/vim-blockle'
Plug 'killphi/vim-ruby-refactoring'
Plug 'freitass/todo.txt-vim'
Plug 'bitc/vim-hdevtools'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/Recover.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'sunaku/vim-ruby-minitest'
Plug 'Chiel92/vim-autoformat'
Plug 'othree/html5.vim'
Plug 'StanAngeloff/php.vim'
Plug 'takac/vim-hardtime'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'Yggdroot/indentLine'
Plug 'mileszs/ack.vim'
Plug 'NicolasWebDev/journal-vim'
call plug#end()
" }}}

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
    set background=dark
    let g:gruvbox_contrast_dark='hard'
    let g:gruvbox_italic=1
    colorscheme gruvbox

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

    " print the letters in english by lowest frequency, to know how to jump
    noremap <F6> :echo "Z J Q X K V B P G W Y F M C U L D H R S N I O A T E"<cr>

    noremap <leader>qq :bd<cr>
    noremap <leader>qQ :Bdelete<cr>
    " Save with <leader>s.
    noremap <Leader>s :update<CR>

    " Hide buffers when they are abandoned.
    set hidden

    set mouse=a		" Enable mouse usage (all modes) in terminals

    augroup anki
        autocmd BufRead ~/docs/lists/anki.md vnoremap <buffer> c1 <Esc>`>a}}<Esc>`<i{{c1::<Esc>
        autocmd BufRead ~/docs/lists/anki.md vnoremap <buffer> c2 <Esc>`>a}}<Esc>`<i{{c2::<Esc>
        autocmd BufRead ~/docs/lists/anki.md vnoremap <buffer> c3 <Esc>`>a}}<Esc>`<i{{c3::<Esc>
    augroup END
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

" VIM-JAVASCRIPT {{{
" Enable syntax highlightning of flow types.
let g:javascript_plugin_flow = 1
" }}}

" VIM-HARDTIME {{{
let g:hardtime_default_on = 1
let g:list_of_normal_keys = ["c", "t", "s", "r", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_visual_keys = ["c", "t", "s", "r", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:hardtime_ignore_quickfix = 1
let g:hardtime_allow_different_key = 1
" }}}

" TAGLIST {{{
set updatetime=250
" }}}

" ACK.VIM {{{
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
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
let NERDTreeIgnore = ['\.pyc$']
" }}}

" SYNTASTIC {{{
let g:syntastic_aggregate_errors = 1
let g:syntastic_python_pylint_post_args = "--rcfile=../.pylintrc"
let g:syntastic_ruby_checkers = ["mri", "rubocop", "reek", 'flog']
let g:syntastic_sh_checkers = ['bashate', 'sh', 'shellcheck']
let g:syntastic_lua_checkers = ["luac", "luacheck"]
let g:syntastic_scss_checkers = ["scss_lint"]
let g:syntastic_css_checkers = ["stylelint"]
let g:syntastic_javascript_checkers = ["eslint", "flow"]
let g:syntastic_javascript_eslint_exe='yarn run eslint --'
let g:syntastic_javascript_flow_exe='yarn run -s 2>/dev/null flow -- status'
let g:syntastic_vim_checkers = ["vint", "vimlint"]
let g:syntastic_mode_map = {'mode': 'active'}
" }}}

" YOUCOMPLETEME {{{
" make YCM compatible with UltiSnips (using supertab)
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
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

" INDENTLINE {{{
let g:indentLine_concealcursor=0
let g:indentLine_char = '┆'
let g:indentLine_color_term = 239
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
" Edit vimrc in another pane.
nnoremap <leader>ev :split $MYVIMRC<cr>
" Source vimrc file
nnoremap <leader>rv :source $MYVIMRC<cr>
iabbrev fs self, cr, uid, ids, context=None):<cr>
iabbrev fc cr, uid, ids, context=context)<cr>
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
vnoremap <leader>' <esc>`<i'<esc>`>a'<esc>
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>
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
