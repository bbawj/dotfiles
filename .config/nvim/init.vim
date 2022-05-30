set nu
set relativenumber
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set signcolumn=yes
set colorcolumn=80
set termguicolors
set clipboard^=unnamed,unnamedplus
set updatetime=100
set splitbelow splitright

call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'

Plug 'morhetz/gruvbox'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'tmsvg/pear-tree'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'https://github.com/jose-elias-alvarez/null-ls.nvim'
Plug 'onsails/lspkind.nvim'

Plug 'L3MON4D3/LuaSnip'

" git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'numToStr/Comment.nvim'

call plug#end()

lua require('bawj')

colorscheme gruvbox

let mapleader = " "

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh :lua require('bawj.telescope').search_dotfiles({ hidden = true })<CR>

" NERDTree mappings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" GitGutter mappings
nmap <leader>j <Plug>(GitGutterNextHunk)
nmap <leader>k <Plug>(GitGutterPrevHunk)

"keep in register
xnoremap <leader>p "_dP

nnoremap <leader>d "_d
vnoremap <leader>d "_d"

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" terminal remaps
map <Leader>tt :vs term://zsh<CR>
tnoremap <leader><Esc> <C-\><C-n>

" Remap splits navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" clipboard with win32yank.exe
" in ~/bin/win32yank.exe
" https://github.com/equalsraf/win32yank/releases {{{
let g:clipboard = {
                        \   'name': 'win32yank-wsl',
                        \   'copy': {
                        \      '+': 'win32yank.exe -i --crlf',
                        \      '*': 'win32yank.exe -i --crlf',
                        \    },
                        \   'paste': {
                        \      '+': 'win32yank.exe -o --lf',
                        \      '*': 'win32yank.exe -o --lf',
                        \   },
                        \   'cache_enabled': 0,
                        \ }
" }}}


