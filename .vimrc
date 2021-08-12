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

set clipboard+=unnamedplus


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

" automatic *.hpp generation
autocmd bufnewfile *.hpp so ~/hpp_header.txt
autocmd bufnewfile *.hpp exe "1," . 13 . "g/Creation Date:.*/s//Creation Date: " .strftime("%d. %B %Y")
autocmd bufnewfile *.hpp exe "1," . 13 . "g/Copyright.*/s//Copyright " .strftime("%Y") " Christoph Thurnheer"
autocmd bufnewfile *.hpp exe "1," . 33 . "g/ifndef.*/s//ifndef " .toupper(expand("%:r"))
autocmd bufnewfile *.hpp exe "1," . 34 . "g/define.*/s//define " .toupper(expand("%:r"))

" automatic *.cpp generation
autocmd bufnewfile *.cpp so ~/cpp_source.txt
autocmd bufnewfile *.cpp exe "1," . 13 . "g/Creation Date:.*/s//Creation Date: " .strftime("%d. %B %Y")
autocmd bufnewfile *.cpp exe "1," . 13 . "g/Copyright.*/s//Copyright " .strftime("%Y") " Christoph Thurnheer"
autocmd bufnewfile *.cpp exe "1," . 39 . "g/#include/s//#include \"" .expand("%:r") ".hpp\""

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
" map <C-K> :py3file /usr/share/clang/clang-format-10/clang-format.py<cr>
" imap <C-K> <c-o>:py3file /usr/share/clang/clang-format-10/clang-format.py<cr>
