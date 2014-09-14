source ~/.vimrc_bepo " remappage des touches de navigation pour le bépo

" .vimrc perso


" ================== /etc/vim/vimrc ======================================
" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
"runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"    \| exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
"if has("autocmd")
"  filetype indent on
"endif

" Source a global configuration file if available
" XXX Deprecated, please move your changes here in /etc/vim/vimrc
"if filereadable("/etc/vim/vimrc.local")
"  source /etc/vim/vimrc.local
"endif

" ====================== mon .vimrc perso ===============================
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

" ignore case in searches
set ignorecase
" without case when search pattern contains only lowercase. works only when
" ignorecase is set
set smartcase

" disable folding by default
set nofoldenable

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

" afficher le numero des lignes
set nu

" Toggle line numbers and fold column for easy copying:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" text indenting
set autoindent
" pour indenter automatiquement en C
" set smartindent

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
colorscheme desert

" highlight cursor line (must come after colorscheme command to take effect)
set cursorline

" change the color of the search occurences
"hi Search cterm=NONE ctermbg=136 ctermfg=blue

" add line number
set number

set nocompatible        " Utilise les défauts Vim (bien mieux !)

" show the line and column number of the cursor position, separated by a
" comma
set ruler

" INDENTATION ET TABULATIONS
" A cet effet lire entre autre ce site : http://tedlogan.com/techblog3.html
"
set softtabstop=4   " how many columns vim uses when you hit Tab in insert mode

set shiftwidth=4	" largeur de l'indentation

set tabstop=4       " numbers of spaces of tab character. A garder toujours a 8 selon le man de vim afin de ne pas tout deformer entre autre a l'impression.

" replace tab with spaces
set expandtab

" <----------------------------

set title           " show title in console title bar


" commande pour mettre les .html en UTF-8
autocmd bufnewfile,filewritepre *.html set fileencoding=utf-8
autocmd bufnewfile,filewritepre *.html set bomb
" commandes pour le html
autocmd BufRead *.html map <F3> :!firefox % >/dev/null 2>&1 &<CR><CR>
autocmd BufNewFile *.html read ~/.vim/skeletons/html.txt | exe "normal ggdd/<title>/e+1\<CR>" | startinsert

set autowrite		" Automatically save before commands like :next and :make

set hidden             " Hide buffers when they are abandoned

set mouse=a		" Enable mouse usage (all modes) in terminals

"set textwidth=80	" Force un hard breaking de la ligne à 80 caractères

" script from this url : http://vim.wikia.com/wiki/Wrap_a_visual_selection_in_an_HTML_tag
" enables to wrap the visual selection with arbitrary tag
"au Filetype html,xml source Data/settings/scripts/wrapwithtag.vim

" asked by the plugin vim-latexsuite
filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
let g:Tex_DefaultTargetFormat = "pdf"

"set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/ter

"set diffexpr=MyDiff()
"function! MyDiff()
  "let opt = '-a --binary '
  "if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  "if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  "let arg1 = v:fname_in
  "if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  "let arg2 = v:fname_new
  "if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  "let arg3 = v:fname_out
  "if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  "let eq = ''
  "if $VIMRUNTIME =~ ' '
    "if &sh =~ '\<cmd'
      "let cmd = '""' . $VIMRUNTIME . '\diff"'
      "let eq = '"'
    "else
      "let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    "endif
  "else
    "let cmd = $VIMRUNTIME . '\diff'
  "endif
  "silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
"endfunction

" @@@@@@@@@@ REGLAGES SPECIALS PYTHON @@@@@@@@@@@@@@@@@@@@@@@@@@

" sert a activer le filetype plugin et le script d'indentation python a chaque
" démarrage
filetype plugin indent on

" sert a activer les options relatives aux python si le fichier est reconnu
" comme tel
autocmd filetype python


" sert a utiliser un script python qui améliore la syntaxe
autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(


