set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
Plugin 'tpope/vim-fugitive'
Plugin 'kabbamine/vcoolor.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'gorodinskiy/vim-coloresque'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'airblade/vim-gitgutter'
Plugin 'yggdroot/indentline'
Plugin 'nvie/vim-flake8'
if has('python')
    Plugin 'davidhalter/jedi-vim'
    Plugin 'axiaoxin/vim-json-line-format'
    Plugin 'SirVer/ultisnips'
endif
Plugin 'mhinz/vim-startify'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'suan/vim-instant-markdown'
Plugin 'tpope/vim-surround'
Plugin 'honza/vim-snippets'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'

"Themes
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'altercation/vim-colors-solarized'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
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
"
""""""""""""""""""""""""""CONFIG""""""""""""""""""""""

"themes
set background=dark
colorscheme PaperColor
" colorscheme solarized

set number

" Cancel the backup
set nobackup
set noswapfile
set noundofile

"always show status bar
set laststatus=2

syntax enable
syntax on

"auto apply vimrc changes
autocmd! bufwritepost .vimrc source %

"auto reload a file
set autoread

"Highlight all search pattern matches
set hlsearch
set incsearch

"ignore case on search
set ignorecase

"When 'ignorecase' and 'smartcase' are both on, if a pattern contains an
"uppercase letter, it is case sensitive, otherwise, it is not.
set smartcase

"show the commands typed
set showcmd

"the cursor will briefly jump to the matching brace when you insert one.
set showmatch

"Save on buffer switch
set autowrite

"mouse on
"set mouse=a

"line numbers
set nu

"Backspace key Deletes 4 spaces at a time
set smarttab

" make backspace work like most other apps
set backspace=2

set autoindent
set smartindent

""Save the file automatically delete the end of the line space or Tab
autocmd BufWritePre * :%s/\s\+$//e

"Automatically delete the end of the blank line when saving the file
autocmd BufWritePre * :%s/^$\n\+\%$//ge

"Fill Tab
" insert spaces on tab
set expandtab
set tabstop=4
set shiftwidth=4
set shiftround

"Code Fold Cursor Folds or unfolds with the za command when indented
" set fdm=indent

"After exiting vim, the content is displayed on the terminal screen and can be used for viewing and copying
set t_ti= t_te=

"Always jumps to the location where the cursor was last opened
autocmd BufReadPost *
      \ if ! exists("g:leave_my_cursor_position_alone") |
      \     if line("'\"") > 0 && line ("'\"") <= line("$") |
      \         exe "normal g'\"" |
      \     endif |
      \ endif


"""""""""""""""""""""""""KEY MAPPING""""""""""""""""""""

"Mapping switch buffer
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>

"Map to switch tabs
nnoremap [t :tabp<CR>
nnoremap ]t :tabn<CR>

" overwrite file
cmap w!! w !sudo tee >/dev/null %:p

"F2 Toggle line number display
nnoremap <F2> :set nonu!<CR>:set foldcolumn=0<CR>

"f3 toggle nerdtree
nmap <silent> <F3> :NERDTreeToggle<CR>

" F4 TagList
nmap <silent> <F4> :TagbarToggle<CR>

" F5 run itself
if exists("$VIRTUAL_ENV")
    autocmd FileType python map <buffer> <F5> :!$VIRTUAL_ENV'/bin/python' %:p<CR>
else
    autocmd FileType python map <buffer> <F5> :!python %:p<CR>
endif

"F6 New tab page
map <F6> <Esc>:tabnew<CR>

" <F7> set paste
set pastetoggle=<F7>

" <F8> sort import and auto pep8
autocmd FileType python map <buffer> <F8> :!autopep8 -i -a --ignore=W690,E501 %:p;isort %:p;<CR><CR>
" <F9> pep8 by yapf
autocmd FileType python map <buffer> <F9> :!yapf -i %:p --style=pep8;isort %:p;<CR><CR>

"Add quotation marks to the current word
nnoremap w" viw<esc>a"<esc>hbi"<esc>lel
nnoremap w' viw<esc>a'<esc>hbi'<esc>lel

" quicker window switching
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" quicker window resize
nnoremap <C-Enter> <C-w>=
nnoremap <C-Left> <C-w><
nnoremap <C-Right> <C-w>>
nnoremap <C-Up> <C-w>+
nnoremap <C-Down> <C-w>-

""""""""""""""""""""""""""""""PLUGIN CONFIG""""""""""""""""""""""""""
" NerdCommenter
let g:NERDSpaceDelims=1

" NERDTREE
" 不显示的文件
let NERDTreeIgnore=['\.pyc$', '\~$']
" show nerdtree when starts up
"autocmd vimenter * NERDTree
"Exit the last buff also exit nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" CtrlP
let g:ctrlp_show_hidden = 1
let g:ctrlp_cmd = 'CtrlPMixed'

" instant-markdown
" make instant markdown not in real time to avoid too much processment
" let g:instant_markdown_slow = 1

" airline
let g:airline_section_y = '%{strftime("%H:%M")}'
" open the tabline
let g:airline#extensions#tabline#enabled = 1
" Tabline the current buffer at both ends of the separator character
let g:airline#extensions#tabline#left_sep = ' '
" The delimiter character at both ends of the buffer is not activated in the tabline
let g:airline#extensions#tabline#left_alt_sep = '|'
"Buffer shows buffer number in tabline
let g:airline#extensions#tabline#buffer_nr_show = 1


" jedi
autocmd FileType python setlocal completeopt-=preview
let g:jedi#completions_command = "<C-n>"

" flake8
let g:flake8_show_in_file = 1
let g:flake8_show_in_gutter = 1
autocmd! BufRead,BufWritePost *.py call Flake8()

" gitgutter
let g:gitgutter_sign_modified = '*'
let g:gitgutter_sign_removed = '-'

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" jshint
autocmd! BufRead,BufWritePost *.js :JSHint

" rainbow_parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" vCoolor.vim
let g:vcoolor_map = '<leader>cp'
let g:vcool_ins_rgb_map = '<leader>cpr'       " Insert rgb color.
let g:vcool_ins_hsl_map = '<leader>cph'       " Insert hsl color.
let g:vcool_ins_rgba_map = '<leader>cpra'      " Insert rgba color.
