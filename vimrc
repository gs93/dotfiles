" syntax highlighting
syntax on

" use vim settings
set nocompatible

" show numbers on the left side
set number

" mode is shown by airline
set noshowmode

"" search
" incremental
set incsearch
" highlight results
set hlsearch
" ignore case
set ignorecase
set smartcase
" clear the highlighting
nmap <silent> <leader>l :nohlsearch<CR>

" convert tab into 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4

" set encryptionmethod (:X)
set cryptmethod=blowfish2

" set ^s to save
map <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a

" don't force save
set hidden

"" commands
" write as root
command! -bar -nargs=0 SudoW :silent exe "write !sudo tee % >/dev/null" | silent edit!
"cmap w!! w !sudo tee % >/dev/null | silent edit!

" auto indent code
set autoindent
"set cindent

" colorcheme
function! s:patch_desert_colors()
    hi clear SpellBad
    hi clear SpellCap
    hi SpellBad cterm=underline ctermfg=red
    hi SpellCap cterm=underline ctermfg=white
endfunction
autocmd! ColorScheme desert call s:patch_desert_colors()
colorscheme desert

" enable ftplugins (see ~/.vim/ftplugin/)
filetype plugin on
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino
au BufRead,BufNewFile *.md set filetype=markdown

" folding
set foldmethod=marker

" views
set viewoptions=cursor,folds
" periodic: find ~/.vim/view -type f -mtime +365 -delete
au BufWinLeave * if expand("%") != "" | mkview | endif
au BufWinEnter * if expand("%") != "" | loadview | endif

" move from ~/.viminfo to .vim/viminfo
set viminfo+=n$HOME/.vim/info

" allow color schemes to do bright colors without forcing bold
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
    set t_Co=16
endif

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

" window
nmap <leader>sw<left>  :topleft  vnew<CR>
nmap <leader>sw<right> :botright vnew<CR>
nmap <leader>sw<up>    :topleft  new<CR>
nmap <leader>sw<down>  :botright new<CR>

" buffer
nmap <leader>s<left>   :leftabove  vnew<CR>
nmap <leader>s<right>  :rightbelow vnew<CR>
nmap <leader>s<up>     :leftabove  new<CR>
nmap <leader>s<down>   :rightbelow new<CR>


"""""""""""""""""
"    Plugins    "
"""""""""""""""""
call plug#begin('~/.vim/plugged')

" Appearance
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'powerline/fonts', { 'do': './install.sh' }
Plug 'bling/vim-bufferline'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'altercation/solarized'

" Writing
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'reedes/vim-wordy', { 'for': [ 'markdown', 'tex' ] }
Plug 'lervag/vimtex', { 'for': 'tex' }

" General Programming
Plug 'Shougo/neocomplete.vim', { 'for': [ 'cpp', 'c', 'go', 'rust' ] }
Plug 'ciaranm/detectindent'
Plug 'vim-syntastic/syntastic'
Plug 'SirVer/ultisnips'
Plug 'gcmt/wildfire.vim'
Plug 'tpope/vim-surround'

" Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'Valloric/YouCompleteMe', { 'for': [ 'rust' ], 'do': './install.py' }

" Go
Plug 'fatih/vim-go', { 'for': 'go' }

call plug#end()

"" Appearance {
    " Bufferline
    let g:bufferline_echo = 0

    " Airline
    let g:airline_theme = 'solarized'
    set laststatus=2 " "vim-airline doesn't appear until I create a new split"
    let g:airline_powerline_fonts = 1

    " Nerdtree
    let NERDTreeShowBookmarks = 1
    let NERDTreeIgnore = ['.o$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$']
    imap <C-e> <Esc>:NERDTreeToggle<CR>
    map <C-e> :NERDTreeToggle<CR>

" }

"" Writing {
    function! s:goyo_enter()
        if exists('$TMUX')
            silent !tmux set status off
            silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
        endif
        set noshowmode
        set noshowcmd
        set scrolloff=999
        Limelight
    endfunction

    function! s:goyo_leave()
        if exists('$TMUX')
            silent !tmux set status on
            silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
        endif
        set showmode
        set showcmd
        set scrolloff=5
        Limelight!
    endfunction

    let g:goyo_width = 100
    let g:goyo_height = '100%'
    autocmd! User GoyoEnter nested call <SID>goyo_enter()
    autocmd! User GoyoLeave nested call <SID>goyo_leave()
    let g:limelight_conceal_ctermfg = 'darkgray'
" }

"" General Programming
let g:neocomplete#enable_at_startup = 1

"" Rust {
    let $RUST_SRC_PATH = $HOME . '/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/'
    let g:syntastic_rust_checkers = ['rustc']
    let g:racer_experimental_completer = 1
    au FileType rust nmap gd <Plug>(rust-def)
" }

"" Go {
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
    let g:go_fmt_command = "goimports"
    let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
    let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
" }

" switching to buffer 1 - 9 is mapped to ,[nOfBuffer]
for buffer_no in range(1, 9)
    execute "nmap <Leader>" . buffer_no . " :b" . buffer_no . "\<CR>"
endfor

" switching to buffer 10 - 100 is mapped to ,0[nOfBuffer]
for buffer_no in range(10, 100)
    execute "nmap <Leader>0" . buffer_no . " :b" . buffer_no . "\<CR>"
endfor

"" clang_complete
" automatically select the first entry in the popup menu, but without inserting it into the code
let g:clang_auto_select = 0
" open quickfix window on error
let g:clang_complete_copen = 1
" automatically complete after ->, ., ::
let g:clang_complete_auto = 1
" complete preprocessor macros and constants
let g:clang_complete_macros = 1
"
let g:clang_snippets_engine = "ultisnips"
" close suggestion window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

"" detect indent
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 4
autocmd BufReadPost *.?pp :DetectIndent
autocmd BufReadPost *.[cChH] :DetectIndent

" vim: set foldmarker={,}
