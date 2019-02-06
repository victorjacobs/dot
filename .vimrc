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
Plug 'terryma/vim-expand-region'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'

call plug#end()


" Always show current position
set ruler

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Theme etc
set gfn=Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
set cmdheight=2
colorscheme peaksea
syntax enable
" Set 7 lines aroun the cursor
set so=7
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
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

command! W w !sudo tee % > /dev/null
