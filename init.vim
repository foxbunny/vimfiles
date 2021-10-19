scriptencoding utf-8
set encoding=utf-8

"Turn off vi compatibility
set nocompatible

" Enable filetype plugins
filetype plugin indent on

" Use a better leader character
let mapleader=","
let g:mapleader=","

" Use vimrc anywhere in the project directories
set exrc

" Prevent executing insecure commands in the project vimrc
set secure

" Ensure vim is always modal
set noinsertmode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLATFORM-SPECIFIC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

try
  exec 'source '.$HOME.'/machine.vim'
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Install vim-plug if missing
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugged')

" Configuration
Plug 'tpope/vim-sensible'

" Interface enhancements
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'jonathanfilip/vim-lucius'

" Editing aids
Plug 'Raimondi/delimitMate'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdcommenter'
Plug 'ncm2/ncm2'
Plug 'mileszs/ack.vim', { 'on': 'Ack' }
Plug 'godlygeek/tabular'
Plug 'frazrepo/vim-rainbow'

" Python
Plug 'hattya/python-indent.vim', { 'for': 'python' }
Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'sophacles/vim-bundle-mako', { 'for': 'python' }

" JavaScript/TypeScript
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'typescript'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'typescript'] }
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'leafgarland/typescript-vim', {'for': 'typescript' }
Plug 'prettier/vim-prettier', { 
      \ 'do': 'yarn install', 
      \ 'branch': 'release/0.x', 
      \ 'for': ['typescript', 'javascript', 'css', 'scss', 'json', 'vue'] }
Plug 'Galooshi/vim-import-js', { 'for': ['javascript', 'typescript'], 'do': 'yarn global add import-js'}

" Markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }

" Other languages
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'gkz/vim-ls', { 'for': 'livescript' }
Plug 'purescript-contrib/purescript-vim', { 'for': 'pures' }
Plug 'chr4/nginx.vim', { 'for': 'nginx' }
Plug 'ekalinin/Dockerfile.vim', { 'for': 'Dockerfile' }
Plug 'fatih/vim-go', { 'for': 'go' }

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI OPTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Faster refresh
set ttyfast

" Use mouse
set mouse=a

" Show right margin
set showtabline=2

" Highlight background beyond 80 columns
let &colorcolumn=join(range(80,9000), ",")

" Show line number
set number

" Show matching braces
set showmatch

" Show current line when in insert mode
autocmd InsertLeave * set nocursorline
autocmd InsertEnter * set cursorline

" Color scheme
silent! colorscheme lucius

" Color scheme style
set background=dark

" Enable status line
set laststatus=2

" Custom status line
set statusline=
set statusline+=%{FugitiveStatusline()}
set statusline+=\ %f%m
set statusline+=%=
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %{&fileformat} 
set statusline+=\ %y
set statusline+=\ 

" Do not cause the long lines to wrap into the next line
set nowrap

" When soft wrap is enabled (`set wrap`), let lines wrap at word boundaries
set linebreak

if has("gui_running")
  " Remove toolbar and other annoying bits and pieces
  set guioptions-=T
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R
  set guioptions-=e
  set guioptions-=m

  " Set GUI font
  if has("unix")
    set guifont=Iosevka\ SS01\ Light\ 14
    set guifontwide=Sarasa\ Term\ J\ 14
    " Increase line spacing +3 px
    set lsp=3
  else
    set guifont=Iosevka_SS01:h12:cANSI
    set guifontwide=Sarasa_Term_J:h12
    " Increase line spacing +3 px
    set lsp=4
  endif

  " Maximize window
  set lines=999 columns=999

  " Auto-save files when focus is lost
  au FocusLost * :wa
endif

if has('nvim')
  " Show what search and replace would do in real time
  set inccommand=split
endif

" Allow syntax highlighting of fenced languages
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'javascript=javascript.jsx']

" Auto-save current file when exiting insert mode
inoremap <Esc> <Esc>:w<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FILE HANDLING OPTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"UNIX line endings
set fileformat=unix
set fileformats=unix,dos
set fileencodings=utf8,latin1

"UTF-8 encoding
set encoding=utf-8

" Yank to system clipboard
" (see http://vim.wikia.com/wiki/Accessing_the_system_clipboard)
if has("unix") && !has("gui_macvim")
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

" Map some extensions to file types manually
au BufNewFile,BufRead,BufWrite *.tpl setlocal ft=mako
au BufNewFile,BufRead,BufWrite Config.in setlocal ft=make

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FORMATTING OPTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Indent on newline
set autoindent

" Expand tabs into spaces
set expandtab

" Defalt tab width in spaces
set tabstop=2

" Default soft-tab width (e.g., when tabbing with spaces)
set softtabstop=2

" Amount of indentation (in spaces) when using indentation commands and
" autoindent.
set shiftwidth=2

" Right margin
set textwidth=79

" Overrides for different filetypes

" JavaScript
au FileType js setlocal textwidth=120
au FileType js setlocal &colorcolumn=join(range(120,9000), ",")

" HTML
au FileType html setlocal tw=0
au FileType html setlocal &colorcolumn=join(range(120,9000), ",")

" Mako template
au FileType mako setlocal tw=0 sw=4 ts=4 sts=4
au FileType mako setlocal &colorcolumn=join(range(120,9000), ",")

" Mako template
au FileType python setlocal sw=4 ts=4 sts=4

" reStructured text
au FileType rst setlocal sw=4 ts=4 sts=4

" VueJS
au FileType vue setlocal tw=0

" Make
au FileType make setlocal noet sw=4 sts=0 tw=0

" dosini
au FileType ini setlocal ts=4 sw=4 sts=4 tw=0

" PureScript
au FileType purs setlocal sw=2 sts=2

" Dockerfile
au FileType Dockerfile setlocal tw=0
au FileType mako setlocal &colorcolumn=join(range(120,9000), ",")

" Prettier (JavaScript) autoformat if config is found
let g:prettier#autoformat_config_present = 1
let g:prettier#autoformat_require_pragma = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EDITING OPTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Location of the undo save files
set undodir=~/.vim_undo

" Location of the swap file dir
set directory=~/.vim_swap//,$TEMP//,.

" Save undo history in a file
set undofile

" ALE
let g:ale_linters = {
      \'javascript': ['eslint'],
      \'typescript': ['tslint', 'tsserver'],
      \}
let g:ale_fixers = {
      \'javascript': ['eslint'],
      \'typescript': ['tslint'],
      \}
let g:ale_fix_on_save = 1

" JSX is highlighted even without the .jsx extension
let g:jsx_ext_required = 0

" Searching is case sensitive only when input includes uppercase letters
set ignorecase
set smartcase

" Markdown tweaks
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 2

" Enable rainbow brackets
let g:rainbow_active = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search (ack.vim)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDCommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
"
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Set update interval for various UI elements (e.g., git gutter)
set updatetime=100

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SHORTCUTS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Quit
noremap <silent> <leader>q :q<CR>

" Quick save
noremap <silent> <leader>w :up<CR>

" Splitting
noremap <silent> <leader>v :vsplit<CR>
noremap <silent> <leader>p :split<CR>

" Toggle background
function! ToggleBackground()
  if (&background == "light")
    set background=dark
  else
    set background=light
  endif
endfunction

nmap <silent> <F12> :call ToggleBackground()<CR>

" Tab navigation
noremap <silent> <leader>tt :tabn<CR>
noremap <silent> <leader>tp :tabp<CR>
noremap <silent> <C-T> :tabnew<CR>
inoremap <silent> <C-T> <Esc>:tabnew<CR>

" Buffers
noremap <silent> <leader>bb :bnext<CR>
noremap <silent> <leader>bm :bmodified<CR>
noremap <silent> <leader>bu :bunload<CR>
noremap <silent> <leader>bq :bdelete<CR>
noremap <silent> <leader><Tab> :b#<CR>

" CtrlP shortcuts
noremap <silent> <leader>o :CtrlP<CR>
noremap <silent> <leader>bl :CtrlPBuffer<CR>

"Map NERDTree
nmap <silent> <leader>` :NERDTreeToggle<CR>  
nmap <silent> <leader>f :NERDTreeFind<CR>

" Spelling mappings: F8 on / F9 off
function! ToggleSpell()
  if (&spell)
    setlocal nospell
  else
    setlocal spell spelllang=en_us
  endif
endfunction

map <silent> <F8> <Esc>:call ToggleSpell()<CR>

" Disable highlighting of search terms
map <silent> <leader>n :nohlsearch<CR>

" Git status
noremap <silent> <leader>S :Gst<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FUNKY STUFF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Clean up trailing spaces
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".") " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Automatically strip trailing whitespace for the following formats
au BufWritePre *.py,*.tpl,*.css,*.coffee,*.js,*.vue,*.scss,*.ls,*.ts,*.tsx :call <SID>StripTrailingWhitespaces()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRLP ignore
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set wildignore+=*.swp,*.zip,*.exe,*.pyc,node_modules

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Focus mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn syntax highlighting off completely. Use F11 to turn it back on.
syntax off
