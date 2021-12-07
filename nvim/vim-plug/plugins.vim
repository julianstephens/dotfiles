" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " Gitgutter
    Plug 'airblade/vim-gitgutter'
	" Lualine
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'kyazdani42/nvim-web-devicons'
	" OneDark theme
	Plug 'joshdick/onedark.vim'
	" Comment
	Plug 'terrortylor/nvim-comment'
	" Auto change html tags
  	Plug 'AndrewRadev/tagalong.vim'
	" Python docstrings
	Plug 'pixelneo/vim-python-docstring'
	" Coc completion
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Vim Snippets
    Plug 'honza/vim-snippets'
    " Vim Bujo - Todo
    Plug 'vuciv/vim-bujo'
	" Fzf
	Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
	Plug 'junegunn/fzf.vim'
	" Unite Vim
	Plug 'Shougo/unite.vim'
	" Citation Vim
	Plug 'rafaqz/citation.vim'
	" Vim Limelight
	Plug 'junegunn/limelight.vim'
	" Iceberg Theme
	Plug 'cocopon/iceberg.vim'
	" Nord Theme
	Plug 'arcticicestudio/nord-vim'
	" Dashboard
	Plug 'goolord/alpha-nvim'
	" Surround
	Plug 'tpope/vim-surround'
	" Indent Line
	Plug 'lukas-reineke/indent-blankline.nvim'
	" Which Key
	Plug 'liuchengxu/vim-which-key'
	" Tokyo Nights Theme
	Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
	" Auto Close Tags
	Plug 'alvan/vim-closetag'
	" Treesitter
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
	Plug 'p00f/nvim-ts-rainbow'
	Plug 'windwp/nvim-ts-autotag'
	" Telescope
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	" ToggleTerm
	Plug 'akinsho/toggleterm.nvim'
	" Tree
	Plug 'kyazdani42/nvim-tree.lua'
	" Buffer line
	Plug 'akinsho/bufferline.nvim'
	" Hop
	Plug 'phaazon/hop.nvim'
	" Dial
	Plug 'monaqa/dial.nvim'
	" Autopairs
	Plug 'windwp/nvim-autopairs'
call plug#end()
	

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
