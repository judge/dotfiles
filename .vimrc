filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" ============ Bundles ============
Bundle 'gmarik/vundle'

Bundle 'tomtom/tcomment_vim'
Bundle 'matchit.zip'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-surround'
Bundle 'Lokaltog/vim-powerline'
Bundle 'altercation/vim-colors-solarized'
Bundle 'docunext/closetag.vim'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'honza/snipmate-snippets'
Bundle 'vim-scripts/Auto-Pairs'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'tpope/vim-repeat'
Bundle 'prefixer.vim'

" ============ General settings ============
filetype plugin indent on

set mouse=a
set ttymouse=xterm2
set ttimeoutlen=10
set ttyfast

set nocompatible
syntax on
set encoding=utf-8

set nostartofline                    " Don’t reset cursor to start of line when moving around.
set clipboard+=unnamed               " OSX clipboard

set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better unix / windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set hidden                          " Allow buffer switching without saving

set foldmethod=indent               " Fold based on indent
set foldnestmax=3                   " Deepest fold is 3 levels
set nofoldenable                    " Dont fold by default

set nobackup
set nowb
set noswapfile

set history=1000
set undolevels=1000

" ============ UI ============
color solarized
set background=dark
let g:solarized_termtrans=0

set showmode
set cursorline
if has('cmdline_info')
    set ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
    set showcmd
endif

set laststatus=2
let g:Powerline_symbols = 'fancy'
let g:Powerline_stl_path_style = 'short'

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
set shiftwidth=2                " Use indents of 2 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=2                   " An indentation every four columns
set softtabstop=2               " Let backspace delete indent

" Remove white space
autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

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
let g:PHP_default_indenting=1

" Weird bug
au BufRead,BufNewFile *.php set ft=html
au BufRead,BufNewFile *.php set ft=php.html

" ============ Mapping ============
let mapleader = ','

nnoremap ; :
nnoremap j gj
nnoremap k gk

" Go to last edit location with ,.
nnoremap ,. '.

" Clear search highlight
nmap <silent> // :nohlsearch<CR>

" Toggle cursorcolumn
nmap <Leader>cc :set cursorcolumn! cursorcolumn?<cr>

" Quickly toggle paste modes
map <leader>p <Esc>:set paste!<CR>
map <F12> <Esc>:set paste!<CR>

" Change Working Directory to that of the current file
cmap cwd lcd %:p:PHd
cmap cd. lcd %:p:h

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Split line at cursor position
nmap K i<Enter><Esc>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Create window splits easier. The default way is Ctrl-w,v and Ctrl-w,s. I remap this to vv and ss
nnoremap <silent> vv <C-w>v<C-w>l
nnoremap <silent> ss <C-w>s<C-w>j

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Vim on the iPad
if &term == "xterm-ipad"
  nnoremap <Tab> <Esc>
  vnoremap <Tab> <Esc>gV
  onoremap <Tab> <Esc>
  inoremap <Tab> <Esc>`^
  inoremap <Leader><Tab> <Tab>
endif

" Buffer navigation
map <F1> :bp<CR>
map <F2> :bn<CR>
imap <F1> <Esc>:bp<CR>
imap <F2> <Esc>:bn<CR>

" ============ Plugin settings ============

" miniBufExplr
let g:miniBufExplMapWindowNavVim=1
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplModSelTarget=1

" CloseTag
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag.vim/plugin/closetag.vim

" TComment
map <silent> <D-/> :TComment<CR>
imap <silent> <D-/> <Esc>:TComment<CR>i
map <silent> <leader>/ :TComment<CR>
let g:tcomment_types = {'php': {'commentstring_rx': '\%%(//\|#\) %s', 'commentstring': '# %s'}}

" Neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_enable_auto_delimiter = 1
" let g:neosnippet#snippets_directory='~/.vim/bundle/snipmate-snippets/snippets'
let g:neosnippet#snippets_directory='~/.vim/snippets'

imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<CR>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1

if has('conceal')
  set conceallevel=2 concealcursor=i
endif

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
