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
    call plug#begin(stdpath('data') . '/plugged')

    " Neoformat for clang format and cmake format
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'sbdchd/neoformat'
    Plug 'Shougo/deoplete.nvim'
    Plug 'zchee/deoplete-clang'
    Plug 'deoplete-plugins/deoplete-clang'
    Plug 'tpope/vim-fugitive'
    Plug 'habamax/vim-asciidoctor'
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }

    " (Optional) Multi-entry selection UI.
    Plug 'junegunn/fzf'

    call plug#end()
    
    " Required for LanguageClient-neovim
    " for operations modifying multiple buffers
    set hidden
    let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ 'cpp': ['clangd']
    \ }

    let g:LanguageClient_autoStart = 1
    let g:LanguageClient_trace = 'verbose'

    nmap <F5> <Plug>(lcn-menu)
    " Or map each action separately
    nmap <silent>K <Plug>(lcn-hover)
    nmap <silent> gd <Plug>(lcn-definition)
    nmap <silent> gr <Plug>(lcn-references)
    nmap <silent> <F2> <Plug>(lcn-rename)

    "
    " set to 1, nvim will open the preview window after entering the markdown buffer
    " default: 0
    let g:mkdp_auto_start = 0

    " set to 1, the nvim will auto close current preview window when change
    " from markdown buffer to another buffer
    " default: 1
    let g:mkdp_auto_close = 1

    " set to 1, the vim will refresh markdown when save the buffer or
    " leave from insert mode, default 0 is auto refresh markdown as you edit or
    " move the cursor
    " default: 0
    let g:mkdp_refresh_slow = 0

    " set to 1, the MarkdownPreview command can be use for all files,
    " by default it can be use in markdown file
    " default: 0
    let g:mkdp_command_for_global = 0

    " set to 1, preview server available to others in your network
    " by default, the server listens on localhost (127.0.0.1)
    " default: 0
    let g:mkdp_open_to_the_world = 0

    " use custom IP to open preview page
    " useful when you work in remote vim and preview on local browser
    " more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
    " default empty
    let g:mkdp_open_ip = ''

    " specify browser to open preview page
    " default: ''
    let g:mkdp_browser = ''

    " set to 1, echo preview page url in command line when open preview page
    " default is 0
    let g:mkdp_echo_preview_url = 0

    " a custom vim function name to open preview page
    " this function will receive url as param
    " default is empty
    let g:mkdp_browserfunc = ''

    " options for markdown render
    " mkit: markdown-it options for render
    " katex: katex options for math
    " uml: markdown-it-plantuml options
    " maid: mermaid options
    " disable_sync_scroll: if disable sync scroll, default 0
    " sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
    "   middle: mean the cursor position alway show at the middle of the preview page
    "   top: mean the vim top viewport alway show at the top of the preview page
    "   relative: mean the cursor position alway show at the relative positon of the preview page
    " hide_yaml_meta: if hide yaml metadata, default is 1
    " sequence_diagrams: js-sequence-diagrams options
    " content_editable: if enable content editable for preview page, default: v:false
    " disable_filename: if disable filename header for preview page, default: 0
    let g:mkdp_preview_options = {
        \ 'mkit': {},
        \ 'katex': {},
        \ 'uml': {},
        \ 'maid': {},
        \ 'disable_sync_scroll': 0,
        \ 'sync_scroll_type': 'middle',
        \ 'hide_yaml_meta': 1,
        \ 'sequence_diagrams': {},
        \ 'flowchart_diagrams': {},
        \ 'content_editable': v:false,
        \ 'disable_filename': 0
        \ }

    " use a custom markdown style must be absolute path
    " like '/Users/username/markdown.css' or expand('~/markdown.css')
    let g:mkdp_markdown_css = ''

    " use a custom highlight style must absolute path
    " like '/Users/username/highlight.css' or expand('~/highlight.css')
    let g:mkdp_highlight_css = ''

    " use a custom port to start server or random for empty
    let g:mkdp_port = ''

    " preview page title
    " ${name} will be replace with the file name
    let g:mkdp_page_title = '「${name}」'

    " recognized filetypes
    " these filetypes will have MarkdownPreview... commands
    let g:mkdp_filetypes = ['markdown']


    let g:neoformat_run_all_formatters = 1
    let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
    let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/'
endif

highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

