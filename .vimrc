set nocompatible              " be iMproved, required
filetype off                  " required

"maximise window on startup.
au GUIEnter * simalt ~x

"show line numbers
set relativenumber
set number

"ignore cases when searching
"set ignorecase
"set gdefault      " Never have to type /g at the end of search / replace again

"higlight search results
set hlsearch

"ignore whitespaces in diffs
set diffopt+=iwhite
set nofixendofline

"Show matching bracets
set showmatch

" Softtabs, 4 spaces
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab


" Make it obvious where 100 characters is
set textwidth=100

"enable syntax highlighting
"syntax enable
:syntax on
set background=dark


" Open new split panes to right and bottom, which feels more natural
" set splitbelow
set splitright

if has('nvim')
else
    set term=screen-256color
endif

" Auto resize Vim splits to active split
set winwidth=104
set winheight=5
set winminheight=5
set winheight=999

" for programming
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"most imortant map map jk to esc
:imap jk <esc>

" Navigate properly when lines are wrapped
nnoremap j gj
nnoremap k gk

" make searching easy
nnoremap S :vimgrep ,, **/*.hpp **/*.cpp **/*.h **/*.c <c-b><right><right><right><right><right><right><right><right><right>
nnoremap s yiw :vimgrep ,\<<c-r>"\>, **/*.hpp **/*.cpp **/*.h **/*.c

let g:clang_library_path='/usr/lib/llvm-3.5/lib/libclang.so'

" search donw into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

"Find the ctags file from vi upwards to root
set tags=./tags;,tags;

"Display all matching files when we tab complete
set wildmenu

"HTML Editing
set matchpairs+=<:>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" smart intedtion meaning not start new line at beginning
set autoindent
set smartindent

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

"use spaces instead of tabs
set expandtab
set smarttab

set nobackup
set nowb
set noswapfile

"1 tab = 4 spaces
set shiftwidth=4
set tabstop=4

"allow hidden buffers to be modified
set hidden

"use jk to exit edit mode
inoremap jk <esc>
"filetype plugin indent on    " required

set ruler " show the cursor position all the time
set showcmd " show incomplete command

let g:cpp_member_varialbe_highlight = 1
let g:cpp_experimental_template_highlight = 1

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

" tell vim to use an undo file
set undofile
" undo file directory
set undodir=~/vim/.vimundo

if has('nvim')
else
    map <C-K> :py3file /usr/share/clang/clang-format-10/clang-format.py<cr>
    imap <C-K> <c-o>:py3file /usr/share/clang/clang-format-10/clang-format.py<cr>
endif

if has('nvim')
    call plug#begin('~/vim/plugged')

    " Neoformat for clang format and cmake format
    Plug 'sbdchd/neoformat'
    Plug 'deoplete-plugins/deoplete-clang'

    call plug#end()
endif

highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

