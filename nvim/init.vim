function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
  endif
endfunction

" VIM-PLUG {{{
    call plug#begin('~/.local/share/nvim/plugged')
    Plug '/usr/bin/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'machakann/vim-highlightedyank'
    Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
    Plug 'RRethy/vim-illuminate'
    Plug 'matze/vim-move'
    Plug 'euclio/vim-markdown-composer', { 'for': 'markdown', 'do': function('BuildComposer') }
    Plug 'easymotion/vim-easymotion'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'vim-airline/vim-airline'
    Plug 'sheerun/vim-polyglot'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs'
    Plug 'morhetz/gruvbox'
    Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
    Plug 'tpope/vim-abolish'
    Plug 'chrisbra/csv.vim'
    Plug 'dhruvasagar/vim-table-mode'
    Plug 'w0rp/ale'
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-line'
    Plug 'tpope/vim-bundler'
    Plug 'tpope/vim-rails'
    Plug 'sukima/xmledit'
    Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --ts-completer' }
    Plug 'andymass/vim-matchup'
    Plug 'Sathors/vim-blockle', { 'for': 'ruby' }
    Plug 'killphi/vim-ruby-refactoring', { 'for': 'ruby' }
    Plug 'freitass/todo.txt-vim'
    Plug 'bitc/vim-hdevtools'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'chrisbra/Recover.vim'
    Plug 'tmhedberg/SimpylFold'
    Plug 'sunaku/vim-ruby-minitest', { 'for': 'ruby' }
    Plug 'takac/vim-hardtime'
    Plug 'Yggdroot/indentLine'
    Plug 'mileszs/ack.vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'NicolasWebDev/journal-vim'
    call plug#end()
" }}}

source ~/.vimrc_bepo " remappage des touches de navigation pour le bépo

" BASIC SETTINGS {{{
   let maplocalleader='-'
   " https://www.reddit.com/r/vim/comments/1vdrxg/space_is_a_big_key_what_do_you_map_it_to/#t1_cerq68d
   map <space> <leader>
   set background=dark
   set expandtab " Replace tab with spaces.
   set hidden " Hide buffers when they are abandoned instead of unloading them.
   set ignorecase " Ignore case in searches.
   set linebreak " Wraps around words, doesn't break a word in the middle.
   set listchars+=extends:>,precedes:<
   set mouse=a " Enable mouse usage (all modes) in terminals.
   set number
   set numberwidth=1
   set path=$PWD/** " Add the current directory to the path recursively. Usefull to make find/sfind work.
   set relativenumber
   set scrolloff=1 " Let always one line above/below the cursor.
   set shiftwidth=4 " Indentation width.
   set showbreak=+ " Character leading wrapped lines.
   set smartcase " Case insensitive when search pattern contains only lowercase. Needs ignorecase on.
   set softtabstop=4 " How many columns vim uses when you hit Tab in insert mode.
   set tabstop=4 " Numbers of spaces of tab character.
   set title " Show title in console title bar.
   set wildmode=list:longest,full
   set cursorline " Highlight cursor line (must come after colorscheme command to take effect).
   set cursorcolumn
   set termguicolors " Enable TrueColors
" }}}

" COMMANDS {{{
    " Add repeated tasks based on a case insensitive pattern.
    command! -nargs=1 GtdAdd read !rg -i <args> ~/work/gtd/repeated_tasks.md
    " Add my weekly tasks.
    command! GtdWeekly read ~/work/gtd/weekly_tasks.md
    " Add my monthly tasks.
    command! GtdMonthly read ~/work/gtd/monthly_tasks.md
" }}}

" AUTOCOMMANDS {{{
    " Disable YCM in the journal, because it makes editing really slow.
    autocmd BufReadPre ~/work/documentation/journal.md let b:ycm_largefile = 1
    " Disable ALE in the journal
    autocmd BufReadPre ~/work/documentation/journal.md let b:ale_enabled = 0

    augroup anki
        autocmd BufRead ~/docs/lists/anki.md vnoremap <buffer> c1 <Esc>`>a}}<Esc>`<i{{c1::<Esc>
        autocmd BufRead ~/docs/lists/anki.md vnoremap <buffer> c2 <Esc>`>a}}<Esc>`<i{{c2::<Esc>
        autocmd BufRead ~/docs/lists/anki.md vnoremap <buffer> c3 <Esc>`>a}}<Esc>`<i{{c3::<Esc>
    augroup END

    augroup filetype_html
        autocmd!
        autocmd FileType html map <F3> :!firefox % >/dev/null 2>&1 &<CR><CR>
    augroup END

    augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
    augroup END

    augroup filetype_sh
        autocmd!
        autocmd FileType sh setlocal foldmethod=marker
    augroup END
" }}}

" MAPPINGS {{{
    " Toggle line numbers and fold column for easy copying:
    nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
    " Open found file in a vertical split.
    cnoremap vfind vertical sfind
    " Print the letters in english by lowest frequency to know where to jump.
    noremap <F6> :echo "Z J Q X K V B P G W Y F M C U L D H R S N I O A T E"<cr>
    noremap <leader>qq :bd<cr>
    noremap <leader>qQ :Bdelete<cr>
    " Save with <leader>s.
    noremap <Leader>s :update<CR>
    " Move current line down.
    " nnoremap <C-T> ddp
    " Move current line up.
    " nnoremap <C-S> ddkP
    " Make current word uppercase.
    inoremap <leader><c-u> <esc>viwUi
    " Make current word uppercase.
    nnoremap <leader><c-u> viwU
    " Edit vimrc in another pane.
    nnoremap <leader>ev :split $MYVIMRC<cr>
    " Source vimrc file
    nnoremap <leader>rv :source $MYVIMRC<cr>
" }}}

" ADDONS SETTINGS {{{
    " VIM-MOVE {{{
        let g:move_map_keys = 0
        nmap <C-t> <Plug>MoveLineDown
        nmap <C-s> <Plug>MoveLineUp
        vmap <C-t> <Plug>MoveBlockDown
        vmap <C-s> <Plug>MoveBlockUp
    " }}}

    " VIM-WHICH-KEY {{{
        nnoremap <silent> <leader> :WhichKey '\'<CR>
        nnoremap <silent> <localleader> :WhichKey '-'<CR>
    " }}}

    " VIM-NERDTREE-SYNTAX-HIGHLIGHT {{{
        let g:NERDTreeFileExtensionHighlightFullName = 1
        let g:NERDTreeExactMatchHighlightFullName = 1
        let g:NERDTreePatternMatchHighlightFullName = 1
    " }}}

    " VIM-DEVICONS {{{
        let g:WebDevIconsUnicodeGlyphDoubleWidth = 0
    " }}}

    " ALE {{{
        let g:ale_sign_column_always = 1
        let g:ale_echo_msg_error_str = 'E'
        let g:ale_echo_msg_warning_str = 'W'
        let g:ale_echo_msg_info_str = 'I'
        let g:ale_echo_msg_format = '[%severity%] %code: %%s [%linter%]'
        let g:ale_linters = {
        \   'javascript': ['eslint'],
        \   'text': ['proselint', 'vale'],
        \   'markdown': ['mdl', 'proselint', 'remark-lint', 'vale'],
        \   'typescript': ['eslint'],
        \   'python': ['pylint', 'flake8'],
        \   'scala': ['fsc', 'sbtserver', 'scalac', 'scalastyle'],
        \}
        let g:ale_fixers = {
        \   '*': ['remove_trailing_lines', 'trim_whitespace'],
        \   'javascript': ['prettier'],
        \   'scala': ['scalafmt', 'remove_trailing_lines', 'trim_whitespace'],
        \   'typescript': ['prettier'],
        \}
        let g:ale_fix_on_save = 1
    " }}}

    " GRUVBOX {{{
        let g:gruvbox_italic=1
        colorscheme gruvbox
    " }}}

    " VIM-SURROUND {{{
        xmap K <Plug>VSurround
    " }}}

    " VIM-EASYMOTION {{{
        nmap k <Plug>(easymotion-s)
    " }}}

    " VIM-JAVASCRIPT {{{
        " Enable syntax highlightning of flow types.
        let g:javascript_plugin_flow = 1
        let g:javascript_conceal_function             = "ƒ"
        let g:javascript_conceal_null                 = "ø"
        let g:javascript_conceal_this                 = "@"
        let g:javascript_conceal_return               = "⇚"
        let g:javascript_conceal_undefined            = "¿"
        let g:javascript_conceal_NaN                  = "ℕ"
        let g:javascript_conceal_prototype            = "¶"
        let g:javascript_conceal_static               = "•"
        let g:javascript_conceal_super                = "Ω"
        let g:javascript_conceal_arrow_function       = "⇒"
        let g:javascript_conceal_noarg_arrow_function = "🞅"
        let g:javascript_conceal_underscore_arrow_function = "🞅"
    " }}}

    " VIM-HARDTIME {{{
        let g:hardtime_default_on = 1
        let g:list_of_normal_keys = ["c", "t", "s", "r", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
        let g:list_of_visual_keys = ["c", "t", "s", "r", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
        let g:hardtime_ignore_quickfix = 1
        let g:hardtime_allow_different_key = 1
    " }}}

    " ACK.VIM {{{
        " Use j and J instead of t and T.
        let g:ack_mappings = {
              \ "j": "<C-W><CR><C-W>T",
              \ "J": "<C-W><CR><C-W>TgT<C-W>j" }
        if executable('rg')
          let g:ackprg = 'rg --vimgrep'
        endif
    " }}}

    " AIRLINE {{{
        if !exists("g:airline_symbols")
            let g:airline_symbols = {}
            let g:airline#extensions#tabline#enabled = 1
            let g:airline_powerline_fonts = 1
            let g:airline_detect_whitespace = 0
            let g:airline_section_warning = ''
            set laststatus=2 " Always display the statusline in all windows
            set showtabline=2 " Always display the tabline, even if there is only one tab
            set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
            let g:airline_symbols.linenr = ''
        endif
    " }}}

    " NERDTREE SETTINGS {{{
        let g:NERDTreeMapOpenInTab = 'j'
        let g:NERDTreeMapOpenInTabSilent = 'J'
        let g:NERDTreeMapOpenVSplit = 'k'
        let g:NERDTreeMapJumpFirstChild = 'S'
        let g:NERDTreeMapJumpLastChild = 'T'
        let g:NERDTreeMapJumpNextSibling = '<C-s>'
        let g:NERDTreeMapJumpPrevSibling = '<C-t>'
        noremap <leader>n :NERDTreeToggle<cr>
        let NERDTreeIgnore = ['\.pyc$', '__pycache__$']
        let NERDTreeShowLineNumbers = 1
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
        let g:UltiSnipsSnippetsDir = $HOME."/.config/nvim/UltiSnips"
        let g:UltiSnipsSnippetDirectories = ['UltiSnips', $HOME.'/.config/nvim/UltiSnips']
    " }}}

    " PYTHON-MODE {{{
        let g:pymode_python = 'python3'
        let g:pymode_virtualenv = 1
        let g:pymode_lint_cwindow = 0
        let g:pymode_doc_bind='Q'
        let g:pymode_lint = 0
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

    " VIM-AUTOPAIRS {{{
        " Rebind the <M-*> shortcuts, which give problems with bepo.
        let g:AutoPairsShortcutToggle = ''
        let g:AutoPairsShortcutFastWrap = ''
        let g:AutoPairsShortcutJump = ''
        let g:AutoPairsShortcutBackInsert = ''
    " }}}
" }}}
