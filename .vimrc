call plug#begin('~/.vim/plugged')

" ****** Syntax Highlighters ******
Plug 'mustache/vim-mustache-handlebars'
Plug 'lumiliet/vim-twig'
Plug 'kchmck/vim-coffee-script'
Plug 'jparise/vim-graphql'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'jparise/vim-graphql'

" ****** Other Plugins ******
" popes stuff
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
" tidy up long lines of code by moving single lines to multi lines
Plug 'AndrewRadev/splitjoin.vim'
" nicer command bar
Plug 'itchyny/lightline.vim'
" fuzzy finding - not necessary, will set this up without plugin soon
Plug 'ctrlpvim/ctrlp.vim'
" allows access to entire undo history in a tree format (not linear)
Plug 'mbbill/undotree'
" git plugins
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'airblade/vim-gitgutter'


" undotree toggle
nnoremap <F5> :UndotreeToggle<CR>
" save undo info in specified location and allow it to persist
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

" ****** Auto Close Brackets/Tags ******
" close brackets
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" ****** Linting/Autocompletion ******
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'
let g:coc_global_extensions = [
	\'coc-markdownlint',
	\'coc-highlight',
	\'coc-tsserver',
	\'coc-git',
	\'coc-json',
	\'coc-python',
	\'coc-phpls',
	\'coc-html',
	\'coc-css',
	\'coc-docker',
	\'coc-yaml',
	\'coc-xml',
	\'coc-emmet',
	\'coc-pairs',
	\'coc-snippets',
	\'coc-yank',
	\'coc-prettier'
	\]

" use tab for autocompletion rather than ctrl+p
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" ****** Themes ******
Plug 'dikiaap/minimalist'
let g:lightline = {
		\	'colorscheme': 'wombat',
		\ 'active': {
		\ 'left': [ [ 'mode', 'paste' ],
		\					[ 'readonly', 'filename', 'modified', 'fugitive' ] ]
		\					},
		\ 'component': {
		\		'fugitive': '%{FugitiveStatusline()}'
		\ }
\}
Plug 'altercation/vim-colors-solarized'
call plug#end()
colorscheme minimalist

" ****** Grep ******
" cycle through results quicker
nmap <silent> <C-N> :cn<CR>zv
nmap <silent> <C-P> :cp<CR>zv
" adjust quick fix window size
au FileType qf call AdjustWindowHeight(3, 30)
function! AdjustWindowHeight(minheight, maxheight)
	 let l = 1
	 let n_lines = 0
	 let w_width = winwidth(0)
	 while l <= line('$')
			 " number to float for division
			 let l_len = strlen(getline(l)) + 0.0
			 let line_width = l_len/w_width
			 let n_lines += float2nr(ceil(line_width))
			 let l += 1
	 endw
	 exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction
" open quick fix window by default
augroup autoquickfix
		autocmd!
		autocmd QuickFixCmdPost [^l]* cwindow
		autocmd QuickFixCmdPost    l* lwindow
augroup END

" ****** General ******
set autoindent
set relativenumber
set softtabstop=0 noexpandtab
set shiftwidth=2
set tabstop=2
set mouse=a
set noswapfile
set wildignore=*/.git/*,*/node_modules/*,*/dist/*,*/build/*
set ttimeoutlen=5
set smartcase
set ignorecase
set lazyredraw
" recognise tsx/ts files
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
" show cursorline on selected window only
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
" allow macro to be repeated with capital Q, rather than @@
nnoremap Q @@
augroup every
	autocmd!
	au InsertEnter * set norelativenumber
	au InsertLeave * set relativenumber
augroup END

" ****** Netrw File Explorer ******
" open netrw file explorer with ctrl+n
map <C-n> :e .<CR>
" open netrw at the last opened location
let g:netrw_keepdir=0

" ****** Git ******
" Default to not read-only in vimdiff
set noro"
