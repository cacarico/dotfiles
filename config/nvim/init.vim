let mapleader = " "

" Tab and spaces
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent

set relativenumber
set nu
" set nohlsearch
set nowrap

set incsearch
set scrolloff=8
set colorcolumn=90
set signcolumn=yes

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nowritebackup
set nobackup
set noswapfile
set noundofile


" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Enable mouse
set mouse=a

" Enable syntax highlight
syntax enable
filetype plugin indent on

nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>so :edit $MYVIMRC<CR>
" ----------------------------------------------
"  NERDTree 
" ----------------------------------------------
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let NERDTreeWinSize = 40

" ----------------------------------------------
"  Glow
" ----------------------------------------------
nnoremap <leader>p :Glow<CR>

" Copy paste yanked instead of deleted 
nmap ,p "0p
nmap ,P "0P


" ----------------------------------------------
"  Fugitive
" ----------------------------------------------


" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" ----------------------------------------------
"  Telescope
" ----------------------------------------------
"
" nmap <leader>l :Telescope file_browser<CR><ESC>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


" ----------------------------------------------
"  Plugins
" ----------------------------------------------

call plug#begin('~/.vim/plugged')
  " NERDTree
  Plug 'preservim/nerdtree'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'ryanoasis/vim-devicons'
  Plug 'Xuyuanp/nerdtree-git-plugin'

  Plug 'nvim-lua/plenary.nvim'

  Plug 'airblade/vim-gitgutter'

  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-fugitive'

  " Plug 'rust-lang/rust.vim'
  Plug 'scrooloose/syntastic'
  " Plug 'neoclide/coc.nvim', {'br:CocInstall coc-json coc-tsserveranch': 'release'}
  Plug 'hashivim/vim-terraform'
  Plug 'vim-airline/vim-airline'
  Plug 'dracula/vim', { 'name': 'dracula' }
  Plug 'gmarik/vundle'
  Plug 'dag/vim-fish'
  Plug 'neovim/nvim-lspconfig'
  Plug 'neovim/nvim-lsp'
  Plug 'preservim/tagbar'

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'mhinz/vim-startify'

  Plug 'tpope/vim-commentary'
  Plug 'xiyaowong/nvim-transparent'
  Plug 'ellisonleao/glow.nvim'

  Plug 'Pocco81/AutoSave.nvim'

  Plug 'towolf/vim-helm'

call plug#end()

colorscheme dracula

set completeopt=menu,menuone,noselect

let g:transparent_enabled = v:true


lua << EOF
local autosave = require("autosave")

autosave.setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)
EOF
