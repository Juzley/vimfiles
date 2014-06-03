"     _____             __            ___ ___ __          ______ ______ 
"   _|     .--.--.-----|  .-----.    |   |   |__.--------|   __ |      |
"  |       |  |  |-- __||_|__ --|    |   |   |  |        |      |   ---|
"  |_______|_____|_____|  |_____|     \_____/|__|__|__|__|___|__|______|
"

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"----------------"
" Vundle Bundles "
"----------------"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
let $GIT_SSL_NO_VERIFY='true'
Bundle 'gmarik/Vundle.vim'

Bundle 'taglist.vim'
"Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-surround'
Bundle 'sjl/gundo.vim'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'ctrlp.vim'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-session'
Bundle 'xolox/vim-reload'
Bundle 'vim-airline'
Bundle 'klen/python-mode'

" Colors
Bundle 'Zenburn'
Bundle 'Solarized'
Bundle 'Molokai'
Bundle 'Sol'
Bundle 'Pychimp/vim-luna' 

call vundle#end()

"---------------"
" Misc Settings "
"---------------"

" Reload settings if we modify this file
au! BufWritePost .vimrc source %

" Always show the status bar (for airline)
set laststatus=2

" Change the file autocomplete behaviour to show longest match, and
" display the list of possible matches if there are multiple matches.
set wildmode=longest:full
set wildmenu

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set autoindent		" always set autoindenting on
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		    " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" Set the correct colours
"if &term =~ "xterm"
  "256 color --
  let &t_Co=256
  " restore screen after quitting
  set t_ti=7[?47h t_te=[2J[?47l8[m
  if has("terminfo")
    let &t_Sf="[3%p1%dm"
    let &t_Sb="[4%p1%dm"
  else
    let &t_Sf="[3%dm"
    let &t_Sb="[4%dm"
  endif

  " Avoid using terminal background color in tmux
  " http://blog.sanctum.geek.nz/256-colour-terminals/
  set t_ut=
"endif
set background=dark

" Switch syntax highlighting on.
" Also switch on highlighting the last used search pattern.
syntax enable
set hlsearch

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")

set tw=79
set expandtab
set cindent shiftwidth=4
set tabstop=4
set cino=(0,:0

" Turn on line numbers
set number

" Set the colorscheme
colorscheme luna-term

" Highlight anything over 80c in red.
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%80v.\+/

" Hide buffers when they are abandoned rather than throwing them away.
set hidden

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

"--------------------"
" Functions/Commands "
"--------------------"

" Taglist toggle. Although taglist has a toggle command, it doesn't support
" jump the cursor to the buffer on open, which TlistOpen does, hence this
" function.
function! TaglistToggle()
    if bufwinnr('__Tag_List__') == -1
        TlistOpen
    else
        TlistClose
    endif
endfunction

command! -range Continue <line1>,<line2>g/^/execute "normal " . (78 - len(getline("."))) . "A \<Esc>A\\\<Esc>"

"--------------"
" Key-mappings "
"--------------"

" Close a buffer while keeping the window
nmap <C-W>! <Plug>Kwbd

" Toggle tag list visibility
map <silent> <F5> :call TaglistToggle()<CR>

" Toggle NERDTree visibility
map <silent> <F4> :NERDTreeToggle<CR>

" F11 toggles paste mode
set pastetoggle=<F11>

" Ctrl+N toggles line numbers
nmap <silent> <C-N> :set invnumber<CR>

" Use Ctrl+F sequences for various FuzzyFinder commands.
" First unmap Ctrl+F (scroll forward).
noremap <C-F> <NOP>
map <silent> <C-F>b :FufBuffer<CR>
map <silent> <C-F>f :FufFile<CR>


"-------------------"
" Tag-list settings "
"-------------------"
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_WinWidth = 40
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Highlight_Tag_On_BufEnter = 1
let Tlist_Show_One_File = 1
let Tlist_Close_On_Select = 1
let Tlist_Compact_Format = 1

"----------------------"
" Vim-session settings "
"----------------------"
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1
let g:session_default_name = "temp"

"------------------"
" Airline settings "
"------------------"
let g:airline_powerline_fonts = 1
let g:airline_theme = "luna"
let g:airline#extensions#whitespace#enabled = 0

"----------------"
" CtrlP settings "
"----------------"
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_jump_to_buffer = 0
let g:ctrlp_working_path_mode = 2
let g:ctrlp_root_markers = ['comp-mdata.pl', '.ACME/', 'content.lst']
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = '$HOME/.vim/ctrlp_cache'

"-----------------"
" PyMode settings "
"-----------------"

let g:pymode = 1
let g:pymode_folding = 0
let g:pymode_doc = 0
let g:pymode_lint_unmodified = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'pep257', 'mccabe', 'pylint']

" Pymode doesn't seem to pick up the VE correctly, add the path manually
let g:pymode_paths = ['/auto/ensoft/thirdparty/python/py2.7-ve/lib/python2.7/site-packages']
