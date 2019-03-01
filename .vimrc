" If shell is fish, set shell to something more standard
if &shell =~# 'fish$'
    set shell=sh
endif

" Install plug if it doesn't exist
if empty(glob('~/.vim/autoload/plug.vim'))
    let plugVersion = '0.10.0'
    let plugChecksum = 'c91f91c7e56578ab7331c784b4bc764eccef774f'

    let plugDownloadUrl = 'https://raw.githubusercontent.com/junegunn/vim-plug/' . plugVersion . '/plug.vim'
    let remoteChecksum = systemlist('curl -s ' . plugDownloadUrl . ' | shasum | awk ''{print $1}''')[0]

    if remoteChecksum != plugChecksum
        echoerr 'Plug installation failed, checksums don''t match!'
    else
        echo 'Downloading plug...'
        silent execute '!curl -sfLo ~/.vim/autoload/plug.vim --create-dirs' plugDownloadUrl
        autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
    endif
endif

call plug#begin()

Plug 'vim-scripts/peaksea'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-markdown'
Plug 'dag/vim-fish'
Plug 'scrooloose/nerdtree'
Plug 'bronson/vim-visual-star-search'

if has('mac')
    Plug 'terryma/vim-expand-region'
    Plug 'junegunn/fzf', { 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'airblade/vim-gitgutter'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'tpope/vim-fugitive'
    Plug 'xuyuanp/nerdtree-git-plugin'
    Plug 'mbbill/undotree'
    Plug 'hashivim/vim-terraform'
    Plug 'udalov/kotlin-vim'
    Plug 'scrooloose/syntastic'
endif

call plug#end()

" Always show current position
set ruler
set updatetime=100

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Theme etc
set gfn=Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
set cmdheight=2
colorscheme peaksea
syntax enable
" Set 7 lines around the cursor
set so=7
" Cursorline
set cursorline
autocmd ColorScheme * hi CursorLine cterm=none ctermbg=236
" Add a bit extra margin to the left
" set foldcolumn=1
set background=dark
" set signcolumn=yes

" Lightline
set laststatus=2

let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [ ['mode', 'paste'],
            \             ['fugitive', 'readonly', 'filename', 'modified'] ],
            \   'right': [ [ 'lineinfo' ], ['percent'] ]
            \ },
            \ 'component': {
            \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
            \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
            \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
            \ },
            \ 'component_visible_condition': {
            \   'readonly': '(&filetype!="help"&& &readonly)',
            \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
            \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
            \ },
            \ 'separator': { 'left': ' ', 'right': ' ' },
            \ 'subseparator': { 'left': ' ', 'right': ' ' }
            \ }

" Quit NERDTree on opening file
let NERDTreeQuitOnOpen = 1

" Cursor shapes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Match brackets
set showmatch
" Matching bracket blinks
set mat=2

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set nobackup
set nowb
set noswapfile

try
    silent !mkdir -p ~/.vim/temp_dirs/undodir > /dev/null 2>&1
    set undodir=~/.vim/temp_dirs/undodir
    set undofile
catch
endtry

" Indentation
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set ai
set si
set wrap

" Tab complete menu
set wildmenu

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Key mappings
noremap <leader>pp :setlocal paste!<cr>
noremap <leader>nn :setlocal number!<cr>
noremap <leader>rn :setlocal relativenumber!<cr>
nnoremap <leader>w :w!<cr>
nnoremap t :Files<cr>
noremap <C-o> :NERDTreeToggle<cr>
nnoremap <F5> :UndotreeToggle<cr>
noremap H ^
noremap L g_
nnoremap K <nop>

autocmd FileType go nmap <leader>i :w!<cr><Plug>(go-install)
autocmd FileType go map <F1> <Plug>(go-doc)

command! W w !sudo tee % > /dev/null

