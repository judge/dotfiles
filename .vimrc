set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" ============ Bundles ============
Bundle 'gmarik/vundle'

Bundle 'tomtom/tcomment_vim'
Bundle 'scrooloose/syntastic" '
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'altercation/vim-colors-solarized'
Bundle 'docunext/closetag.vim'
Bundle 'ervandew/supertab'
Bundle 'SirVer/ultisnips'

" ============ General settings ============
filetype plugin indent on
syntax on
set mouse=a
set ttymouse=xterm2
set ttyfast
set nostartofline                    " Don’t reset cursor to start of line when moving around.
" set clipboard+=unnamed                " OSX clipboard

scriptencoding utf-8
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better unix / windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000                    " Store a ton of history (default is 20)
set hidden                          " Allow buffer switching without saving

set foldmethod=indent               " Fold based on indent
set foldnestmax=3                   " Deepest fold is 3 levels
set nofoldenable                    " Dont fold by default

set nobackup
set nowb
set noswapfile

" ============ UI ============
if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
    color solarized
    set background=dark
    let g:solarized_termtrans=1
    let g:solarized_termcolors=256
endif

set showmode
set cursorline
if has('cmdline_info')
    set ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
    set showcmd
endif

if has('statusline')
    set laststatus=2
    set statusline=%<%f\                        " Filename
    set statusline+=%w%h%m%r                    " Options
    set statusline+=\ [%{&ff}/%Y]               " Filetype
    set statusline+=\ [%{getcwd()}]             " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%     " Right aligned file nav info
    let g:Powerline_symbols = 'fancy'
    let g:Powerline_stl_path_style = 'short'
endif

set backspace=indent,eol,start
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set mat=2                       " How many tenths of a second to blink when matching brackets
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap to
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=5                 " Minimum lines to keep above and below cursor
set list listchars=tab:»·,trail:·
set showbreak=↪
set gcr=a:blinkon0              " Disable cursor blink
set autoread                    " Reload files changed outside vim
set noerrorbells                " No annoying sound on errors
set novisualbell
set t_vb=
set notimeout
set noesckeys
set timeoutlen=1000
set ttimeoutlen=0

if has("gui_running")
    set t_Co=256
    " Show tab number (useful for Cmd-1, Cmd-2.. mapping)
    autocmd VimEnter * set guitablabel=%N:\ %t\ %M
    set lines=60
    set columns=160
    set guifont=Menloh14,Monaco:h17
    set guioptions-=r
    set guioptions-=L
    set guioptions-=T"
else
    let g:CSApprox_loaded = 1
endif"

" ============ Formatting ============
set nowrap                      " Wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent

" Change cursor shape in different modes (iTerm2)
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" ============ Completion ============
set wildmode=list:longest,list:full
set wildmenu                    " Enable ctrl-n and ctrl-p to scroll thru matches

" Stuff to ignore when tab completing
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.class,.svn,*.gem
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.swp,*~,._*
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" ============ PHP ============
let g:php_folding = 0
let g:php_html_in_strings = 1
let g:php_parent_error_close = 1
let g:php_parent_error_open = 1
let g:php_no_shorttags = 1

" ============ Session management ============
nmap SS :wa<CR>:mksession! ~/.vim/sessions/
nmap SO :wa<CR>:so ~/.vim/sessions/
" Autosaving current session on exit
function! SaveSession()
  if v:this_session != ""
    echo "Saving."
    exe 'mksession! ' . '"' . v:this_session . '"'
  else
    echo "No Session."
  endif
endfunction
au VimLeave * :call SaveSession()

" ============ Mapping ============
let mapleader = ','

nnoremap ; :
nnoremap j gj
nnoremap k gk

" Go to last edit location with ,.
nnoremap ,. '.

" Clear search highlight
nmap <silent> // :nohlsearch<CR>

nmap <Leader>cc :set cursorcolumn! cursorcolumn?<cr>

" Quickly toggle paste modes
map <leader>p <Esc>:set paste!<CR>

" Change Working Directory to that of the current file
cmap cwd lcd %:p:PHd
cmap cd. lcd %:p:h

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Change inside various enclosures with Cmd-" and Cmd-'
" The f makes it find the enclosure so you don't have to be standing inside it
nnoremap <D-'> f'ci'
nnoremap <D-"> f"ci"
nnoremap <D-(> f(ci(
nnoremap <D-)> f)ci)
nnoremap <D-[> f[ci[
nnoremap <D-]> f]ci]"

" Move between split windows by using the four directions H, L, I, N
" (note that  I use I and N instead of J and K because  J already does
" line joins and K is mapped to GitGrep the current word
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-j> <C-w>j

" Use numbers to pick the tab you want (like iTerm)
map <silent> <D-1> :tabn 1<cr>
map <silent> <D-2> :tabn 2<cr>
map <silent> <D-3> :tabn 3<cr>
map <silent> <D-4> :tabn 4<cr>
map <silent> <D-5> :tabn 5<cr>
map <silent> <D-6> :tabn 6<cr>
map <silent> <D-7> :tabn 7<cr>
map <silent> <D-8> :tabn 8<cr>
map <silent> <D-9> :tabn 9<cr>

" Create window splits easier. The default way is Ctrl-w,v and Ctrl-w,s. I remap this to vv and ss
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" Resize windows with arrow keys
nnoremap <D-Up> <C-w>+
nnoremap <D-Down> <C-w>-
nnoremap <D-Left> <C-w><
nnoremap <D-Right>  <C-w>>

" ============ Plugin settings ============
" CtrlP
let g:ctrlp_working_path_mode = 2
nnoremap <silent> <D-t> :CtrlP<CR>
nnoremap <silent> <leader>t :CtrlP<CR>
nnoremap <silent> <D-r> :CtrlPBuffer<CR>
nnoremap <silent> <leader>r :CtrlPBuffer<CR>
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$|\.DS_Store' }

" SuperTab
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = '<c-n>'
let g:SuperTabLongestEnhanced = 1

" UltiSnips
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsListSnippets = '<S-Tab>'
let g:UltiSnipsJumpForwardTrigger = '<C-l>'
let g:UltiSnipsJumpBackwardTrigger = '<C-h>'
let g:UltiSnipsSnippetDirectories = ['bundle/ultisnips/UltiSnips', 'snippets']

" CloseTag
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim

" TComment
" Command-/ to toggle comments
map <D-/> :TComment<CR>
imap <D-/> <Esc>:TComment<CR>i
map <leader>/ :TComment<CR>
