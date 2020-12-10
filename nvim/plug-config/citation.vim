let g:citation_vim_mode="zotero" 
let g:citation_vim_zotero_path="/mnt/c/Users/leahs/Zotero/" 
let g:citation_vim_zotero_version=5 
let g:citation_vim_key_format="{author}{date}{title}"
let g:citation_vim_cache_path='~/.config/nvim/.citation-cache'
let g:citation_vim_outer_prefix="["
let g:citation_vim_inner_prefix="@"
let g:citation_vim_suffix="]"
let g:citation_vim_et_al_limit=3

nmap <C-C> [unite]
nnoremap [unite] <nop>

nnoremap <silent>[unite]c  :<C-u>Unite -buffer-name=citation-start-insert -default-action=append      citation/key<cr>
nnoremap <silent>[unite]co :<C-u>Unite -input=<C-R><C-W> -default-action=start -force-immediately citation/file<cr>
nnoremap <silent><leader>cuo :<C-u>Unite -input=<C-R><C-W> -default-action=start -force-immediately citation/url<cr>
nnoremap <silent>[unite]ci :<C-u>Unite -input=<C-R><C-W> -default-action=preview -force-immediately citation/combined<cr>



