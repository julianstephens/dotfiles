" set leader key
let g:mapleader = "\<Space>"
let g:maplocalleader = ";"

syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			        " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set t_Co=256                            " Support 256 colors
set tabstop=4                           " Insert 4 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set number                              " Line numbers
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set termguicolors                       " Enable 256color support for tmux
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set laststatus=2                        " Always display statusline 

" set clipboard=unnamedplus               " Copy paste between vim and everything else
autocmd FileType markdown,md,mkd setlocal spell " Enable spellcheck for markdown files

augroup pencil
  autocmd!
  autocmd FileType markdown,md,mkd call pencil#init({'wrap': 'soft', 'autoformat': 1})
                               \ | call litecorrect#init()
  autocmd FileType text         call pencil#init()
                               \ | call litecorrect#init()
augroup END

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

let clap_provider_todoist = {
\ 'source': {-> Todoist__listProjects()},
\ 'sink': 'Todoist',
\}

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm
