" ----------------------------------------------------------------------------
"  Vundle setup
" ----------------------------------------------------------------------------
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" ============ Bundles ============
Bundle 'gmarik/vundle'

Bundle 'tomtom/tcomment_vim'
Bundle 'docunext/closetag.vim'
Bundle 'vim-scripts/Auto-Pairs'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'kien/ctrlp.vim'

Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'stephenmckinney/vim-solarized-powerline'
Bundle 'altercation/vim-colors-solarized'

" Syntax
Bundle 'scrooloose/syntastic'
Bundle 'groenewege/vim-less'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'php.vim'

" ============ General settings ============
filetype plugin indent on

if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim   " use the built-in Matchit plugin
endif

set ttimeout
set ttimeoutlen=50

set mouse=a
set ttymouse=xterm2
set ttyfast

set nocompatible
set encoding=utf-8

set nostartofline               " Don’t reset cursor to start of line when moving around.
set clipboard+=unnamed          " OSX clipboard

set shortmess+=filmnrxoOtT      " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better unix / windows compatibility
set virtualedit=onemore         " Allow for cursor beyond last character
set hidden                      " Allow buffer switching without saving

set foldmethod=indent           " Fold based on indent
set foldnestmax=3               " Deepest fold is 3 levels
set nofoldenable                " Dont fold by default
function! NeatFoldText() "{{{2
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = split(filter(split(&fillchars, ','), 'v:val =~# "fold"')[0], ':')[-1]
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let length = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g'))
  return foldtextstart . repeat(foldchar, winwidth(0)-length) . foldtextend
endfunction
set foldtext=NeatFoldText()
" }}}2

set nobackup
set nowb
set noswapfile

set history=1000
set undolevels=1000

" ============ UI ============
syntax enable
let g:solarized_visibility = 'low'
set background=dark
colorscheme solarized
if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800

set showmode
set nocursorcolumn
set nocursorline

if has('cmdline_info')
	set ruler
	set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
	set showcmd
endif

set laststatus=2
set backspace=indent,eol,start
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set smarttab
set mat=2                       " How many tenths of a second to blink when matching brackets
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap to
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=5                 " Minimum lines to keep above and below cursor
set showbreak=↪									" String to put before wrapped screen lines
set gcr=a:blinkon0              " Disable cursor blink
set autoread                    " Reload files changed outside vim
set noerrorbells                " No annoying sound on errors
set novisualbell
set t_vb=

" Define characters to show when you show formatting
" stolen from https://github.com/tpope/vim-sensible
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
    let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
  endif
endif
set list

if has("gui_running")
	set t_Co=256
	" Show tab number (useful for Cmd-1, Cmd-2.. mapping)
	autocmd VimEnter * set guitablabel=%N:\ %t\ %M
	set lines=60
	set columns=160
	set guifont=Menlo14,Menlo:h14
	set guioptions-=r
	set guioptions-=L
	set guioptions-=T"
else
	let g:CSApprox_loaded = 1
	set t_Co=256
	set ttimeoutlen=10
	augroup FastEscape
		autocmd!
		au InsertEnter * set timeoutlen=0
		au InsertLeave * set timeoutlen=1000
	augroup END
endif

" Place a dark gray line at 80 columns to visibly mark the point where most
" code should end or be wrapped
" set colorcolumn=80
" highlight colorcolumn ctermbg=0

" ============ Formatting ============
set nowrap                      " Wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=2                " Use indents of 2 spaces
set shiftround
set noexpandtab                 " Real tabs, no spaces (WordPress)
set tabstop=2                   " An indentation every four columns
set softtabstop=2               " Let backspace delete indent

" Remove white space
" autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

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
set wildmenu                  " Enable ctrl-n and ctrl-p to scroll thru matches

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
	 \	 exe "normal! g`\"" |
	 \ endif
" Remember info about open buffers on close
set viminfo^=%

" Netrw
let g:netrw_liststyle = 1
let g:netrw_preview = 1 " preview window shown in a vertically split

" ============ Mapping ============
let mapleader = ','

nnoremap j gj
nnoremap k gk

nnoremap ' `
nnoremap ` '

noremap 0 ^
noremap ^ 0

" Go to last edit location with ,.
nnoremap ,. '.

" Clear search highlight
nmap <silent> // :nohlsearch<CR>

" Quickly toggle paste modes
map <leader>p <Esc>:set paste!<CR>
set pastetoggle=<F12>
map <F12> <Esc>:set paste!<CR>

" Change Working Directory to that of the current file
cmap cwd lcd %:p:PHd
cmap cd. lcd %:p:h

cmap w!! w !sudo tee % >/dev/null

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

" Semicolon at end of line by typing ;;
inoremap ;; <C-o>A;<esc>

" Buffer navigation
map <F1> :bp<CR>
map <F2> :bn<CR>
imap <F1> <Esc>:bp<CR>i
imap <F2> <Esc>:bn<CR>i

nnoremap <F3> :<C-U>setlocal lcs=tab:»·,trail:· list! list? <CR>

" ============ Plugin settings ============


" miniBufExplr
let g:miniBufExplSplitBelow = 0
let g:miniBufExplForceSyntaxEnable = 0
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMaxSize = 0
let g:miniBufExplModSelTarget = 1
let g:miniBufExplTabWrap = 1
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplCheckDupeBufs = 0

" CloseTag
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag.vim/plugin/closetag.vim

" change the default EasyMotion shading to something more readable with Solarized
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
let g:EasyMotion_mapping_w = '<Space>'
let g:EasyMotion_mapping_b = '<leader><Space>'

" TComment
map <silent> <D-/> :TComment<CR>
imap <silent> <D-/> <Esc>:TComment<CR>i
map <silent> <leader>/ :TComment<CR>

" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_quiet_warnings = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
au VimEnter * highlight clear SignColumn

" Powerline
let g:Powerline_symbols = 'fancy'
let g:Powerline_stl_path_style = 'short'
let g:Powerline_colorscheme='solarized256'
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" Surround
autocmd FileType php let b:surround_112 = "<?php \r ?>"     " p
autocmd FileType php let b:surround_63 = "<?php \r ?>"      " ?

" CtrlP
let g:ctrlp_jump_to_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_split_window = 0
let g:ctrlp_max_height = 20
let g:ctrlp_extensions = ['tag']
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

let g:ctrlp_map = '<leader>,'
nnoremap <leader>. :CtrlPMixed<cr>

" Neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 0
let g:neocomplcache_enable_underbar_completion = 0
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_enable_auto_delimiter = 1
" let g:neosnippet#snippets_directory='~/.vim/bundle/snipmate-snippets/snippets'
let g:neosnippet#snippets_directory='~/.vim/snippets'
let g:neocomplcache_max_list = 5

imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1

" Disable Scratch
set completeopt-=preview

" For snippet_complete marker.
if has('conceal')
	set conceallevel=2 concealcursor=i
endif

" PHP settings
autocmd BufRead,BufNewFile *.php set ft=php.html
nmap <silent> <F4>
 \ :!ctags -f ./tags
 \ --langmap="php:+.inc"
 \ -h ".php.inc" -R --totals=yes
 \ --tag-relative=yes --PHP-kinds=+cf-v .<CR>
set tags=./tags,tags

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

autocmd! bufwritepost .vimrc source %

" HTML indentitation fix
autocmd FileType html setlocal indentkeys-=*<Return>
