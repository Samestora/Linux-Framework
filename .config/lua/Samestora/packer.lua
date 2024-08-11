-- This file can be loaded by calling `lua require('plugins')` from your init.vim


-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]


return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	use ({
		'danilo-augusto/vim-afterglow',
		config = function()
			vim.cmd('colorscheme afterglow')
		end
	})
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                          , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

    use ( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use ('nvim-treesitter/playground')
    use ('theprimeagen/harpoon')
    use ('mbbill/undotree')
    use ('tpope/vim-fugitive')
    
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }

    use({
	    "L3MON4D3/LuaSnip",
    	-- follow latest release.

	    tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    	-- install jsregexp (optional!:).
	    run = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
    })
    
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
            'quangnguyen30192/cmp-nvim-ultisnips', 'hrsh7th/cmp-nvim-lua',

            'octaltree/cmp-look', 'hrsh7th/cmp-path', 'hrsh7th/cmp-calc',
            'f3fora/cmp-spell', 'hrsh7th/cmp-emoji'
        }
    }

    use {
        'tzachar/cmp-tabnine',
        run = './install.sh',
        requires = 'hrsh7th/nvim-cmp'
    }
    use "rafamadriz/friendly-snippets"
    
    use {
        'hrsh7th/nvim-cmp',
        config = function ()
            require'cmp'.setup {
                snippet = {
                    expand = function(args)
                        require'luasnip'.lsp_expand(args.body)

                    end
                },

                sources = {
                    { name = 'luasnip' },
                    -- more sources
                },
            }
        end
    }
    use {
        'SirVer/ultisnips',
        requires = {'honza/vim-snippets'}
    }

    use {
        'quangnguyen30192/cmp-nvim-ultisnips',
        requires = {'hrsh7th/nvim-cmp', 'SirVer/ultisnips'}
    }


    use { 'saadparwaiz1/cmp_luasnip' }

end)
