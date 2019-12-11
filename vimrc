call plug#begin()
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'idanarye/vim-vebugger', { 'branch': 'develop' }
call plug#end()

set encoding=utf-8
set nocompatible

" enable syntax highlighting and plugins
syntax on
filetype plugin indent on

set number
set relativenumber
set numberwidth=5

set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

set completeopt=menu,preview
set complete-=i

set laststatus=2
set t_Co=256
set modelines=5
set hlsearch
"set incsearch

set path=**
set wildmenu
set wildignore=*.o,build/*,docs/*,**/node_modules/*

set makeprg=make

set list
set listchars=tab:→\ ,nbsp:␣,trail:•,eol:¶,precedes:«
if v:version > 704
	set listchars+=space:·
endif
set fillchars+=vert:\ 
"set cursorline

hi CursorLine cterm=NONE ctermbg=255 guifg=#eeeeee
hi StatusLine ctermfg=8 ctermbg=15 guifg=#808080 guibg=#ffffff
hi SpecialKey ctermfg=251 guifg=#999999
hi NonText ctermfg=251·guifg=#999999

set wildcharm=<C-z>
nnoremap <tab>   :CtrlPBuffer<cr>
nnoremap <S-tab> :b#<cr>
nnoremap <cr>    :nohlsearch<cr>
nnoremap <f2>    :set relativenumber!<cr>
nnoremap <f3>    :set list!<cr>
nnoremap <f5>   :cprev<cr>
nnoremap <f6>   :cnext<cr>
nnoremap <f9>   :VBGtoggleBreakpointThisLine<cr>
nnoremap <f10>  :VBGstepOver<cr>
nnoremap <f11>  :VBGstepIn<cr>
nnoremap <f12>  :VBGstepOut<cr>

function! GitBranch()
	return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

set statusline=[%n]\ %f%m%r%=%{GitBranch()}\ %l:%c\ %P\ [%{&fileformat}]


autocmd BufNewFile,BufRead *.json,*.jsonc set ft=javascript
autocmd BufEnter *.js source ~/.vim/javascript.vim

inoremap {<CR> {<CR>}<ESC>O

command! MakeTags !ctags -R include/ src/

let g:ctrlp_working_path_mode = 'rwa'
let g:ctrlp_custom_ignore = '\v[\/](build|docs|node_modules)$'

let g:vdebug_options = {
\	'on_close': 'stop',
\	'continuous_mode': 0,
\	'layout': 'horizontal',
\}
