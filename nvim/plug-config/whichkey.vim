nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
set timeoutlen=500

let g:which_key_map =  {}

" Ignore
let g:which_key_map.e = 'which_key_ignore'
let g:which_key_map.n = { 'name': 'which_key_ignore' }
let g:which_key_map.r = { 'name': 'which_key_ignore' }
let g:which_key_map.s = 'which_key_ignore'
let g:which_key_map.w = 'which_key_ignore'
let g:which_key_map.a = { 'name': 'which_key_ignore' }
let g:which_key_map.p = { 'name': 'which_key_ignore' }
let g:which_key_map.q = { 'name': 'which_key_ignore' }
let g:which_key_map.q = 'which_key_ignore'
let g:which_key_map["Q"] = 'which_key_ignore'
let g:which_key_map["/"] = 'which_key_ignore'

" Clap
nnoremap <leader>ff :Clap files<CR>
nnoremap <leader>fe :Clap filer<CR>
nnoremap <leader>fg :Clap grep2<CR>
nnoremap <leader>fr :Clap recent_files<CR>
nnoremap <leader>fb :Clap buffers<CR>
let g:which_key_map.f = {
      \ 'name': '+Files',
      \ 'f': 'Finder',
      \ 'e': 'Explore',
      \ 'g'   : 'Grep',
      \ 'r'   : 'Recent files',
      \ 'b'   : 'Buffers',
      \ }

" CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>cd  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>ce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>cs  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>ct  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>ck  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>cp  :<C-u>CocListResume<CR>
" Applying codeAction to the selected region.
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>cab  <Plug>(coc-codeaction)
" Symbol renaming.
nmap <leader>cr <Plug>(coc-rename)
" Apply AutoFix to problem on the current line.
nmap <leader>cq  <Plug>(coc-fix-current)
let g:which_key_map.c = {
      \ 'name' : '+CoC' ,
      \ 'd' : 'Diagnostics' ,
      \ 'e' : 'Extensions'  ,
      \ 's' : 'Commands'    ,
      \ 'o' : 'Outline'    ,
      \ 't' : 'Symbols'                ,
      \ 'j' : 'Next diagnostic'        ,
      \ 'k' : 'Previous diagnostic'    ,
      \ 'p' : 'Resume latest list'     ,
      \ 'r' : 'Rename'     ,
      \ 'a' : 'Code action for selected'     ,
      \ 'ab' : 'Code action for buffer'     ,
      \ 'q' : 'AutoFix line'     ,
      \ }

" Python Doctring
nnoremap <leader>dd :Docstring<CR>
nnoremap <leader>dl :DocstringLine<CR>
let g:which_key_map.d = {
      \ 'name' : '+PyDocstring' ,
      \ 'd' : 'Docstring' ,
      \ 'l' : 'Docstring line'  ,
      \ }

" Theme/Todo
let g:which_key_map.t = { 
      \ 'name': 'Theme/Todo' , 
      \ 'c': 'Change theme' , 
      \ 'g': 'Git todo' , 
      \ 't': 'General todo' , 
      \ }

" GitGutter
let g:which_key_map.h = { 'name' : 'GitGutter' }

" EasyMotion navigation
" Move to line
map <leader>ml <Plug>(easymotion-bd-jk)
nmap <leader>ml <Plug>(easymotion-overwin-line)
" Move to word
map  <leader>mw <Plug>(easymotion-bd-w)
nmap <leader>mw <Plug>(easymotion-overwin-w)"
let g:which_key_map.m = { 
      \ 'name': 'EasyMotion' , 
      \ 'w': 'Move word' , 
      \ 'l': 'Move line' , 
      \ }

nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pc :PlugClean<CR>
nnoremap <leader>pu :PlugUpdate<CR>
let g:which_key_map.p = { 
      \ 'name': 'Plug' , 
      \ 'i': 'Install' , 
      \ 'c': 'Clean' , 
      \ 'u': 'Update' , 
      \ }

call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
