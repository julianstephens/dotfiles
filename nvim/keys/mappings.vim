" Better saving and quitting
noremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>

" Quick source current file
nnoremap <leader>s :source %<CR>

" Better window navigation
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>
nnoremap <leader>rp :resize 100<CR>

" Split panes
nnoremap vs :vsp<CR>
nnoremap sp :sp<CR>

" Turn off highlighting
nnoremap <leader>nh :nohl<CR>

" I hate escape more than anything else
inoremap jk <Esc>
inoremap kj <Esc>

" Use control-c instead of escape
nnoremap <C-c> <Esc>

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Easy CAPS
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<Esc>

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Plug in mappings 
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <leader>e :NvimTreeToggle<cr>
nnoremap mw :HopWord<cr>
nnoremap ml :HopLineStart<cr>
nnoremap <leader>/ :CommentToggle<cr>
vnoremap <leader>/ :CommentToggle<cr>
