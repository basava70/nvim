-- This file can be loaded by calling `lua require('plugins')` from your init.vim

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use "nvim-lua/plenary.nvim"

  -- All colorschemes
  use 'AlexvZyl/nordic.nvim'
  use 'rmehri01/onenord.nvim'

  use 'shaunsingh/nord.nvim'

  use 'folke/tokyonight.nvim'

  use { "catppuccin/nvim", as = "catppuccin" }

  use "EdenEast/nightfox.nvim" -- Packer

  -- which-key
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      --[[ require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      } ]]
    end
  }

  -- bufferline
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

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
  -- use 'theprimeagen/harpoon'

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

  -- lsasaga
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    requires = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  })

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
