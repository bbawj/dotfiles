vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.tabstop=2
vim.opt.softtabstop=2
vim.opt.shiftwidth=2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile=true
vim.opt.incsearch = true
vim.opt.scrolloff=8
vim.opt.signcolumn="yes"
vim.opt.colorcolumn="80"
vim.opt.termguicolors = true
vim.opt.updatetime=100
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.mouse="a"
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.lazyredraw = true
vim.opt.clipboard="unnamed,unnamedplus"
-- " clipboard with win32yank.exe
-- " in ~/bin/win32yank.exe
-- " https://github.com/equalsraf/win32yank/releases {{{
vim.g.clipboard = {
  name = "win32yank-wsl",
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf"
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf"
  },
  cache_enabled = false,
}

local Remap = require("bawj.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local tnoremap = Remap.tnoremap
local nmap = Remap.nmap

inoremap("jk", "<ESC>")
inoremap("kj", "<ESC>")

xnoremap("<leader>p", "\"_dP")

nnoremap("<CR>", ":noh<CR>")

nmap("<Leader>tt", ":vs term://zsh<CR>")
tnoremap("<leader><Esc>", "<C-\\><C-n>")

nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

nnoremap("<C-Left>", "<cmd>silent vertical resize +3<CR>")
nnoremap("<C-Right>", "<cmd>silent vertical resize -3<CR>")
nnoremap("<C-Up>", "<cmd>silent resize +3<CR>")
nnoremap("<C-Down>", "<cmd>silent resize -3<CR>")

nnoremap("<C-S-Tab>", "<cmd> tabprev<CR>")
nnoremap("<C-Tab>", "<cmd> tabnext<CR>")

nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

require("bawj")

