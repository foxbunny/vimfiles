scriptencoding utf-8
set encoding=utf-8

"Turn off vi compatibility
set nocompatible

" Enable syntax highlighting
syntax on

" Enable filetype plugins
filetype plugin indent on

" Use a better leader character
let mapleader=","
let g:mapleader=","

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

if exists('*minpac#init')
  call minpac#init()

  " Configuration
  call minpac#add('tpope/vim-sensible')
  "call minpac#add('editorconfig/editorconfig-vim')
  call minpac#add('jonathanfilip/vim-lucius')

  " Interface enhancements
  call minpac#add('scrooloose/nerdtree')
  call minpac#add('sjl/gundo.vim')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('itchyny/lightline.vim')
  call minpac#add('ctrlpvim/ctrlp.vim')
  call minpac#add('bling/vim-bufferline')
  call minpac#add('airblade/vim-gitgutter')

  " Editing aids
  call minpac#add('Townk/vim-autoclose')
  call minpac#add('alvan/vim-closetag')
  call minpac#add('tpope/vim-surround')
  call minpac#add('w0rp/ale')
  call minpac#add('scrooloose/nerdcommenter')

  " Python
  call minpac#add('hattya/python-indent.vim')
  call minpac#add('hdima/python-syntax')
  call minpac#add('sophacles/vim-bundle-mako')

  " JavaScript/TypeScript
  call minpac#add('mxw/vim-jsx')
  call minpac#add('pangloss/vim-javascript')
  call minpac#add('jason0x43/vim-js-indent')
  call minpac#add('othree/html5.vim')
  call minpac#add('posva/vim-vue')
  call minpac#add('leafgarland/typescript-vim')

  " Other languages
  call minpac#add('gkz/vim-ls')
  call minpac#add('purescript-contrib/purescript-vim')

  " Package management
  call minpac#add('k-takata/minpac', {'type': 'opt'})
endif

" Update installed packages and removed unused ones
command! Pacsync  packadd minpac | source $MYVIMRC | call minpac#update() | call minpac#clean() | UpdateRemotePlugins


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI OPTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Faster refresh
set ttyfast

" Use mouse
set mouse=a

" Show right margin
set showtabline=2

" Highlight 80 columns
set colorcolumn=80

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
set background=light

" Enable status line
set laststatus=2

let g:lightline = {
      \   'colorscheme': 'wombat',
      \   'active': {
      \     'left': [ [ 'mode', 'paste' ],
      \               [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \   },
      \   'component': {
      \     'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \     'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \     'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \   },
      \   'component_visible_condition': {
      \     'readonly': '(&filetype!="help"&& &readonly)',
      \     'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \     'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \   },
      \   'component_function': {
      \     'filename': 'LightlineFilename'
      \   },
      \ }

" Filename function for Lightline (show full path)
function! LightlineFilename()
  return expand('%')
endfunction

" We don't need to show the --INSEERT-- mode because it's part of lightline.
set noshowmode

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

  " Set GUI fonts
  if has("unix")
    set guifont="Bitstream Vera Sans Mono 12"
    set guifontwide="MS Gothic 12"
    " Increase line spacing +3 px
    set lsp=3
  else
    set guifont=Bitstream_Vera_Sans_Mono:h12:cANSI
    set guifontwide=MS_Gothic:h12
    " Increase line spacing +3 px
    set lsp=4
  endif

  " Maximize window
  set lines=999 columns=999
  au GUIEnter * simalt ~x
endif

if has('nvim')
  " Show what search and replace would do in real time
  set inccommand=split
endif

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
if has("unix")
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

" HTML
au FileType html setlocal tw=0

" Mako template
au FileType mako setlocal tw=0 sw=4 ts=4 sts=4

" Mako template
au FileType python setlocal tw=0 sw=4 ts=4 sts=4

" reStructured text
au FileType rst setlocal sw=4 ts=4 sts=4

" VueJS
au FileType vue setlocal tw=0

" Make
au FileType make setlocal noet tw=4 sw=4 sts=0 tw=0

" dosini
au FileType ini setlocal tw=4 sw=4 sts=4 tw=0

" PureScript
au FileType purs setlocal tw=2 sw=2 sts=2

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

" Graphical undo (gundo)
nnoremap <silent> <leader>u <Esc>:GundoToggle<CR>

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
