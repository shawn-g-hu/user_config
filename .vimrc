"set nocompatible              " required
"filetype off                  " required
"
"" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"
"" alternatively, pass a path where Vundle should install plugins
""call vundle#begin('~/some/path/here')
"
"" let Vundle manage Vundle, required
"Plugin 'gmarik/Vundle.vim'
"
"" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
"
"Plugin 'scrooloose/syntastic' "python syntax
"Plugin 'nvie/vim-flake8' "pep8
"let python_highlight_all=1
"syntax on
"Plugin 'altercation/vim-colors-solarized' "color scheme
"
"" All of your Plugins must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required

"bash-like autocompletion behavior 
set wildmode=longest,list,full
set wildmenu

"for editing in command mode (don't forget to use :q and C-F though)
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>



"switch between buffers without having to write changes, lose marks, etc.
"allows for multiple buffers to be open simultaneously
set hidden

"switch buffers with prompt
nnoremap gb :ls<CR>:b<Space>
nnoremap gv :ls<CR>:bd<Space>

"Ngb with N integer to jump directly to buffer
let c = 1
while c <= 399
  execute "nnoremap " . c . "gb :" . c . "b\<CR>"
  let c += 1
endwhile

"close buffer with WQ
:command WQ :w|bd


"split navigations and then maximize window you tab to
"nnoremap <C-J> <C-W><C-J><C-W>_
"nnoremap <C-K> <C-W><C-K><C-W>_
"nnoremap <C-L> <C-W><C-L><C-W>_
"nnoremap <C-H> <C-W><C-H><C-W>_

"set minimum window height and width to 0 to maximize minimization
set wmw=0
set wmh=0

"resize to equal using Ctrl
"nnoremap <C-s> <C-w>=

"quick resizing
nnoremap <S-Up> <C-w>+
nnoremap <S-Down> <C-w>- 
nnoremap <S-Left> <C-w>< 
nnoremap <S-Right> <C-w>> 

"allow tabbing in insert mode
imap <F2> <C-o><C-w>
imap <F3> <C-o><C-p>

"search in insert
imap <F4> <C-o>/

"delete with f4 and f6 so you don't need to move hands
inoremap <F5> <Backspace>
inoremap <F6> <Backspace>


" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

set tabstop=2
set softtabstop=2
set expandtab
set number
set bg=dark
set smarttab smartindent autoindent
set shiftwidth=2
set fileformat=unix

set encoding=utf-8



"gotoend with G
:nnoremap <CR> G

"easier end of paragraph
:nnoremap ] }
:nnoremap [ {
"last location
:nnoremap ;; ``

"pan to result when searching
set incsearch
"make search case insensitive
set ignorecase
"unless you search or something with caps
set smartcase
"don't highlight search results
set nohlsearch

set history=100
set undolevels=100
"leave a three line buffer when moving to top and bottom of screen, so one can
"see context
set scrolloff=3

"let tab switch to next window
nnoremap <F2> <C-w>w
nnoremap <F3> <C-w><C-p>
"nnoremap <F2> <C-w>p

"ctrl-number to go to tab number

noremap <C-1> 1gt 
noremap <C-2> 2gt 
noremap <C-3> 3gt 
noremap <C-4> 4gt 
noremap <C-5> 5gt 
noremap <C-6> 6gt 
noremap <C-7> 7gt 
noremap <C-8> 8gt 
noremap <C-9> 9gt 
noremap <C-0> 10gt 

"set the up and down keys to behave intuitively on wrapped lines
"arrow keys still move up and down a line
nnoremap j gj
nnoremap k gk
"set the left and right arrow keys to wrap to next line when at end fo line
set whichwrap+=<,>,h,l,[,]

"switch colon and semicolon in normal mode to save keystrokes on ex mode
"commands
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

set visualbell
