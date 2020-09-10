" Change bujo window size
let g:bujo#window_width = 50 

" Map open todo in repo
nnoremap <leader>tg :Todo<CR>

" Map open general todo
nnoremap <leader>tt :Todo g<CR>

" Map new task
nmap <C-S> <Plug>BujoAddnormal
imap <C-S> <Plug>BujoAddinsert

" Map check off task
nmap <C-Q> <Plug>BujoChecknormal
imap <C-Q> <Plug>BujoCheckinsert
