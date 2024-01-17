local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    }
  }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'p00f/nvim-ts-rainbow'
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  }
  use 'nvim-treesitter/nvim-treesitter-context'

  --themes
  use {'EdenEast/nightfox.nvim', config =   function ()
    require('nightfox').setup({
      options = {
        transparent = true,
      },
    })
    vim.cmd 'colorscheme nordfox'
  end}

  -- " Status Lines
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}

  -- " Misc
  use 'http://github.com/tpope/vim-surround'
  -- use {
  --   "windwp/nvim-autopairs",
  --   config = function() require("nvim-autopairs").setup {} end
  -- }
  use 'windwp/nvim-ts-autotag'
  use { 'j-hui/fidget.nvim', tag = 'legacy' }

  -- " File explorer
  use 'kyazdani42/nvim-tree.lua'

  -- " LSP related
  use 'williamboman/mason.nvim'
  use 'williamboman/nvim-lsp-installer'
  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'folke/trouble.nvim'

  -- " Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'onsails/lspkind.nvim'

  -- " Snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  -- " Git integration
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  -- " Comments
  use 'numToStr/Comment.nvim'
  use { 'JoosepAlviste/nvim-ts-context-commentstring', config = function ()
    vim.g.skip_ts_context_commentstring_module = true
  end
  }

  -- " Debugger
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'
  -- GO
  -- use 'ray-x/go.nvim'
  -- use 'ray-x/guihua.lua' -- recommanded if need floating window support
  -- JAVA
  -- use 'mfussenegger/nvim-jdtls'

  use 'lervag/vimtex'
end)
