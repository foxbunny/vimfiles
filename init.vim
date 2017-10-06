scriptencoding utf-8
set encoding=utf-8

"Turn off vi compatibility
set nocompatible

" Infect everything with pathogen
execute pathogen#infect()

" Enable syntax highlighting
syntax on

" Enable filetype plugins
filetype plugin indent on

" Use a better leader character
let mapleader=","
let g:mapleader=","

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

"Show line number
set number

"Show matching braces
set showmatch

" Whitespace characters
set listchars=eol:¶,tab:→\ ,space:·

" Show whitespace characters
set list

" Show current line when in insert mode
autocmd InsertLeave * set nocursorline
autocmd InsertEnter * set cursorline

" Color scheme
colorscheme lucius

" Color scheme style
set background=dark

" Enable status line
set laststatus=2

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ }

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

  " Set GUI fonts
  if has("unix")
    set guifont="Bitstream Vera Sans Mono 12"
    set guifontwide="MS Gothic 12"
  else
    set guifont=Bitstream_Vera_Sans_Mono:h12:cANSI
    set guifontwide=MS_Gothic:h12
  endif

  " Maximize window
  set lines=999 columns=999
  au GUIEnter * simalt ~x
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

" Save undo history in a file
set undofile

" Syntastic 
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_python_checkers = ["flake8"]
let g:syntastic_javascript_checkers = ["eslint"]
let g:syntastic_vue_checkers = []
let g:syntastic_rst_checkers = []
let g:syntastic_cpp_check_header = 1
hi SyntasticError guifg=red

" Searching is case sensitive only when input includes uppercase letters
set ignorecase
set smartcase

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

" Tab navigation
noremap <silent> <leader><Tab> :tabn<CR>
noremap <silent> <leader><S-Tab> :tabp<CR>

" CtrlP shortcuts
noremap <silent> <C-T> :tabnew<CR>:CtrlP<CR>
inoremap <silent> <C-T> <Esc>:tabnew<CR>:CtrlP<CR>
noremap <silent> <leader>o :CtrlP<CR>

"Map NERDTree
nmap <silent> <leader>` :NERDTreeToggle<CR>  
nmap <silent> <leader>f :NERDTreeFind<CR>

" Graphical undo (gundo)
nnoremap <silent><leader>u <Esc>:GundoToggle<CR>

" Spelling mappings: F8 on / F9 off
map <silent> <F8> <Esc>:setlocal spell spelllang=en_us<CR>
map <silent> <F9> <Esc>:setlocal nospell<CR>

" Disable highlighting of search terms
map <silent> <leader>n :nohlsearch<CR>

" Run commit with signoff
noremap <silent> <leader>S :Gcommit --signoff<CR>

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
au BufWritePre *.py,*.tpl,*.css,*.coffee,*.js,*.vue,*.scss,*.ls :call <SID>StripTrailingWhitespaces()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PYTHON
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

noremap <silent> <leader>t :!tox<CR>
noremap <silent> <leader>T :!tox -- %:p<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRLP ignore
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("unix")
  set wildignore+=*/node_modules/*,*.swp,*.zip,*.exe,*.pyc
else
  set wildignore+=*\\node_modules\\*,*.swp,*.zip,*.exe,*.pyc
endif
