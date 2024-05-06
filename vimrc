" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Helps force plugins to load correctly when it is turned back on below.
filetype off
filetype plugin on
filetype indent on

" Turn syntax highlighting on.
syntax on

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
" set cursorcolumn

" Set shift width to 4 spaces.
set shiftwidth=2

" Show line numbers.
set number
set relativenumber

" Show file stats.
set ruler

" Blink cursor on error instead of beeping.
set visualbell

" Encoding.
set encoding=utf-8

" Security.
set modelines=0

" Show color column at 80 characters width, visual reminder of keepingcode line within a popular line width.
" set colorcolumn=80

" "Whitespace.
set nowrap
set autoindent
set smartindent
set tabstop=2 shiftwidth=2 expandtab

" Search
set incsearch
set ignorecase
set smartcase
set showmatch
" set hlsearch

" Do not let cursor scroll below or above N number of lines when scrolling
set scrolloff=6

" Enable auto completion menu after pressing TAB.
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,*.mp4,*.mkv,*.avi,*.flac,*.mp3,*.mov,*.m4v,*.m4a

" Allow hidden buffers.
set hidden

" Rendering.
set ttyfast

" Last line.
set showmode
set showcmd

" Set the commands to save in history default number is 20
set history=1000

" PLUGINS ----- {{{

call plug#begin('~/.vim/plugged')

Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'

call plug#end()

colorscheme molokai

" }}}

" STATUS BAR ----- {{{

" Enable the status line always
set laststatus=2

" Define a function to get the git branch if available
function! GetGitBranch()
  let branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  return (v:shell_error ? '' : '  '.branchname)
endfunction

function! GetCurrentMode()
  let modes = {'n': 'NORM', 'i': 'INS', 'v': 'VIS', 'V': 'V-LN', "\<C-v>": 'V-BLK', 'c': 'CMD'}
  return get(modes, mode()[0], 'UNK')
endfunction

" Clear status line
set statusline=
" Mode
set statusline+=\ %{GetCurrentMode()}\ >
" Git branch
set statusline+=%{GetGitBranch()}\ >
" Filename and path
set statusline+=\ %f
" Modified flag
set statusline+=%m
" Readonly flag
set statusline+=%r
" Percent through file
set statusline+=\ (%p%%)
" Filetype
set statusline+=\ [%Y]

" Right-aligned items
set statusline+=%=
" Encoding
set statusline+=[%{&fileencoding?&fileencoding:&encoding}
" File format (unix/dos/mac)
set statusline+=\ (%{&ff})]
" Line and column number
set statusline+=\ Line:%l/%L\ Col:%c

" }}}

" MAPPINGS ----- {{{

" Quickly exit INSERT mode
inoremap cc <Esc>

" Press space to type the : character
nnoremap <space> :

" Navigate split windows easier
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize split windows easier
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" NERDTree mappings
" Map F3 to toggle NERDTree open and close
nnoremap <F3> :NERDTreeToggle<cr>

" }}}

" VIMSCRIPT ----- {{{

if version >=703
  set undodir=~/.vim/backup
  set undofile
  set undoreload=1000
endif

augroup cursor_off
  autocmd!
  autocmd WinLeave * set nocursorline
  autocmd WinEnter * set cursorline
augroup END

if has('gui_running')
  set background/dark
  colorscheme molokai
  set guifont=Monospace\ Regular\ 12
  
  " Hide the toolbar
  set guioptions-=T
  " Hide the left-side scroll bar
  set guioptions-=L
  " Hide the right-side scroll bar
  set guioptions-=r
  " Hide the menu bar
  set guioptions-=m
  " Hide the bottom scroll bar
  set guioptions-=b

  " Map the F4 key to toggle the menu, toolbar and scroll bar
  nnoremap <F4> :if &guioptions=~#'mTr'<Bar>
    \set guioptions-=mTr<Bar>
    \else<Bar>
    \set guioptions+=mTr<Bar>
    \endif<CR>

endif

" }}}
