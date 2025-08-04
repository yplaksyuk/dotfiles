
autocmd BufNewFile,BufRead *.json setlocal ft=json
autocmd BufNewFile,BufRead *.jsonc setlocal ft=jsonc

autocmd BufEnter *.js source ~/.vim/filetype/javascript.vim
autocmd BufEnter *.behavior source ~/.vim/filetype/behavior.vim

