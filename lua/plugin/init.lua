-- This file can be loaded by calling `lua require('plugins')` from your init.vim

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use "nvim-lua/plenary.nvim"

  -- use {
  --   'rmehri01/onenord.nvim',
  --   -- require('onenord').setup()
  -- }
  --
  -- use{
  --   'shaunsingh/nord.nvim',
  --   -- require("nord").setup{}
  -- }
  -- use 'folke/tokyonight.nvim'
  -- Lua
-- vim.cmd[[colorscheme tokyonight]]
--
  -- Nordic theme
  use{
    'AlexvZyl/nordic.nvim',
    require("nordic").setup{}
  }

  -- telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter', run = ":TSUpdate"
  }

  -- harpoon
  use 'theprimeagen/harpoon'

  -- undotree
  use 'mbbill/undotree'

  -- fugitive
  use 'tpope/vim-fugitive'

  --- nvim-tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
    config = function()
      require("nvim-tree").setup {}
    end
  }

  -- Lsp Zero
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
      {'neovim/nvim-lspconfig'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }

  -- lualine
  use { 'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', opt = true },
  config = function()
    require("lualine").setup{}
  end
}

--indent_blankline
use {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    require("indent_blankline").setup{}
  end
}

-- Comment
use {
  'numToStr/Comment.nvim',
  config = function()
    require("Comment").setup{}
  end
}

-- vim-tmux-navigator
use {
  'christoomey/vim-tmux-navigator'
}

-- vimtex
use 'lervag/vimtex'

end)
