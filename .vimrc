set nocompatible
filetype off                  " required due to some vundle runtimepath thing- refer to line below that turns it back on
runtime macros/matchit.vim
"
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
"

Plugin 'vim-syntastic/syntastic' "syntax checker
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_loc_list_height = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
" see :h syntastic-loclist-callback
function! SyntasticCheckHook(errors)
    if !empty(a:errors)
        let g:syntastic_loc_list_height = min([len(a:errors), 5])
    endif
endfunction
let g:syntastic_enable_signs = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_enable_highlighting = 1

let g:syntastic_echo_current_error = 1

let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["xml"] }

highlight SyntasticError guibg=#4f0000
highlight SyntasticWarning guibg=#2f000f

Plugin 'flazz/vim-colorschemes'

"fancy statusline plugin (can remove and configure own statusline if wanted)
Plugin 'itchyny/lightline.vim'

"Plugin 'nvie/vim-flake8' "pep8
"let python_highlight_all=1
"Plugin 'rhysd/vim-clang-format' "Plugin to interface with clang-format for C-family automatic formatting

" All of your Plugins must be added before the following line
call vundle#end()        
filetype plugin indent on

"tmux and other multiplexers have to use escape sequences to send arrow keys,
"so this undoes the mapping inside vim
"set t_ku= [1;5A
"set t_kd= [1;5B
"set t_kr= [1;5C
"set t_kl= [1;5D
map <Esc>^[[A <Up>
map <Esc>^[[B <Down>
map <Esc>^[[C <Right>
map <Esc>^[[D <Left>
"map <Esc>[A <Up>
"map <Esc>[B <Down>
"map <Esc>[C <Right>
"map <Esc>[D <Left>
"" Console movement
"cmap <Esc>[A <Up>
"cmap <Esc>[B <Down>
"cmap <Esc>[C <Right>
"cmap <Esc>[D <Left>

"used to handle a phenomenon where xterm would clear the system clipboard
"upon exiting vim. requires xsel; if you want to fix this behavior for all
"programs and not just vim, install parcellite or glipper
"https://stackoverflow.com/questions/6453595/prevent-vim-from-clearing-the-clipboard-on-exit
"autocmd VimLeave * call system("xsel -ib", getreg('+'))
set clipboard=unnamedplus

if executable("xsel")

  function! PreserveClipboard()
    call system("xsel -ib", getreg('+'))
  endfunction

  function! PreserveClipboadAndSuspend()
    call PreserveClipboard()
    suspend
  endfunction

  autocmd VimLeave * call PreserveClipboard()
  nnoremap <silent> <c-z> :call PreserveClipboadAndSuspend()<cr>
  vnoremap <silent> <c-z> :<c-u>call PreserveClipboadAndSuspend()<cr>

endif


colorscheme molokai
hi VisualNOS guibg=#2D2B2B
hi Visual guibg=#2D2B2B
hi CursorLine guibg=#2B2929

let g:lightline = {
      \ 'colorscheme': 'PaperColor_dark',
      \ 'component_function': {
      \   'filename': 'LightLineFilename',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ }

function! LightLineFilename()
  return expand('%')
endfunction

"let g:lightline = {
"      \ 'colorscheme': 'ir_black',
"      \ }

" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal

"enable mouse in all modes
set mouse=a

"leave status bar on at all times
set laststatus=2
"since it shows up in the status bar, destroy the mode line
set noshowmode

" This shows what you are typing as a command
set showcmd 

"syntax highlighting
syntax on

"system clipboard reg to + reg
let g:clipbrdDefaultReg = '+'

" Set off the other paren
highlight MatchParen ctermbg=4

"search in ancestor directories for tag files
set tags=./tags;,tags;

"bash-like autocompletion behavior in command mode
set wildmode=longest,list
set wildmenu

"for editing in command mode (don't forget to use q: and C-F though)
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

let paste_mode = 0 " 0 = normal, 1 = paste

func! Paste_on_off()
   if g:paste_mode == 0
      set paste
      let g:paste_mode = 1
   else
      set nopaste
      let g:paste_mode = 0
   endif
   return
endfunc
nnoremap <silent> <F10> :call Paste_on_off()<CR>
set pastetoggle=<F10>


" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

set tabstop=4
set softtabstop=4
set expandtab
set number
set bg=dark
set smarttab smartindent autoindent
set shiftwidth=2
set fileformat=unix
set cursorline

set encoding=utf-8

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

"gotoend with G
":nnoremap <CR> G

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
"map N Nzz
""map n nzz

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
nnoremap <Tab> <C-w>w
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
nnoremap j gj
nnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja
"arrow keys still move up and down a line
"set the left and right arrow keys to wrap to next line when at end fo line
set whichwrap+=<,>,h,l,[,]

"switch colon and semicolon in normal mode to save keystrokes on ex mode
"commands
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

set visualbell
