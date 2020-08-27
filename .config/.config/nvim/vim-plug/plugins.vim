" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'	
    " Undotree
    Plug 'mbbill/undotree'
    " Gitgutter
    Plug 'airblade/vim-gitgutter'
    " Airline
	Plug 'vim-airline/vim-airline'
	" Dark theme
	Plug 'joshdick/onedark.vim'
	" Auto pairs
	Plug 'jiangmiao/auto-pairs'
	" NerdCommenter
	Plug 'preservim/nerdcommenter'
	" Auto change html tags
  	Plug 'AndrewRadev/tagalong.vim'
	" Text navigation
	Plug 'easymotion/vim-easymotion'
	" Python docstrings
	Plug 'pixelneo/vim-python-docstring'
	" Coc completion
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Ranger
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    " Vim Snippets
    Plug 'honza/vim-snippets'
call plug#end()
	

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
