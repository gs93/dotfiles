" syntax highlighting
syntax on

" show numbers on the left side
set number

"" search
" incremental
set incsearch
" highlight results
set hlsearch
" ignore case
set ignorecase
set smartcase

" convert tab into 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4

" set cryptionmethod (:X)
set cryptmethod=blowfish

" set , instead of \
let mapleader = ","

"" shortcuts
" set ^s to save
map <C-s> :w<CR>:mkview<CR>
imap <C-s> <Esc>:w<CR>:mkview<CR>a

"" commands
" write as root
command! -bar -nargs=0 SudoW :silent exe "write !sudo tee % >/dev/null" | silent edit!

" auto indent code
set autoindent
"set cindent

" write file when switch to other file
set autowrite

" set colorcheme
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
au BufWinLeave *.?pp mkview!
au BufWinEnter *.?pp silent loadview

" move from ~/.viminfo to .vim/viminfo
set viminfo+=n$HOME/.vim/info

"""""""""""""""""
"    plugins    "
"""""""""""""""""
"" miniBufExpl {{{
" navigate with arrows
let g:miniBufExplMapWindowNavArrows = 1

" enable C-Tab and C-S-Tab
let g:miniBufExplMapCTabSwitchBufs = 1

" for taglist
let g:miniBufExplModSelTarget = 1

" switching to buffer 1 - 9 is mapped to ,[nOfBuffer]
for buffer_no in range(1, 9)
    execute "nmap <Leader>" . buffer_no . " :b" . buffer_no . "\<CR>"
endfor

" switching to buffer 10 - 100 is mapped to ,0[nOfBuffer]
for buffer_no in range(10, 100)
    execute "nmap <Leader>0" . buffer_no . " :b" . buffer_no . "\<CR>"
endfor
" }}}

"" nerdtree {{{
imap <C-e> <Esc>:NERDTreeToggle<CR>
map <C-e> :NERDTreeToggle<CR>
" }}}

"" taglist {{{
" place taglist on the right side
let g:Tlist_Use_Right_Window = 1

" exit
let g:Tlist_Exit_OnlyWindow = 1

" shortcuts
imap <C-l> <Esc>:TlistToggle<CR>
map <C-l> :TlistToggle<CR>
" }}}

"" doxygen {{{
" shortcuts
imap <C-d> <Esc>:Dox<CR>
map <C-d> :Dox<CR>
" }}}

"" clang_complete {{{
" automatically select the first entry in the popup menu, but without inserting it into the code
let g:clang_auto_select = 0
" open quickfix window on error
let g:clang_complete_copen = 1
" automatically complete after ->, ., ::
let g:clang_complete_auto = 1
" complete preprocessor macros and constants
let g:clang_complete_macros = 1
" use lib 
let g:clang_library_path = "/usr/lib/llvm"
let g:clang_use_library = 1
"
let g:clang_snippets_engine = "ultisnips"
" close suggestion window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" }}}

"" supertab {{{
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
" }}}

