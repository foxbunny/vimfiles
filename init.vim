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
set listchars=tab:⇥\ ,eol:↵

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FORMATTING OPTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Indent on newline
set autoindent

" Expand tabs into spaces
set expandtab

" Defalt tab width in spaces
set tabstop=4

" Default soft-tab width (e.g., when tabbing with spaces)
set softtabstop=4

" Right margin
set textwidth=79

" Overrides for different filetypes

" HTML
au FileType html setlocal textwidth=0

" Mako template
au FileType mako setlocal textwidth=0
au FileType mako setlocal sw=4
au FileType mako setlocal ts=4
au FileType mako setlocal sts=4

" reStructured text
au FileType rst setlocal textwidth=79
au FileType rst setlocal sw=4
au FileType rst setlocal ts=4
au FileType rst setlocal sts=4

" CSS and SCSS
au FileType css setlocal sw=2
au FileType css setlocal ts=2
au FileType css setlocal sts=2
au FileType css setlocal textwidth=0
au FileType scss setlocal sw=2
au FileType scss setlocal ts=2
au FileType scss setlocal sts=2
au FileType scss setlocal textwidth=0

"BASH script settings 
autocmd FileType sh setlocal sw=2
autocmd FileType sh setlocal ts=2
autocmd FileType sh setlocal sts=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EDITING OPTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use standard omnicompletion for Python
au FileType python setlocal omnifunc=pythoncomplete#Complete
au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

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
let g:syntastic_javascript_checkers = ["jslint"]
let g:syntastic_rst_checkers = []
let g:syntastic_cpp_check_header = 1
hi SyntasticError guifg=red

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
au BufWritePre *.py,*.tpl,*.css,*.coffee,*.scss :call <SID>StripTrailingWhitespaces()
