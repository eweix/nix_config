return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    lazy = false,
    config = true,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    init = function()
      vim.g.vimtex_view_method = "skim"
    end,
  },

  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
    opts = {
      window = { width = 100 },
    },
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  {
    "Vigemus/iron.nvim",
    lazy = true,
    cmd = {
      "IronRepl",
      "IronReplHere",
      "IronRestart",
      "IronSend",
      "IronFocus",
      "IronHide",
      "IronWatch",
      "IronAttach",
    },
    keys = {
      "<space>sc",
      "<space>sc",
      "<space>sf",
      "<space>sl",
      "<space>su",
      "<space>sm",
      "<space>mc",
      "<space>mc",
      "<space>md",
      "<space>s<cr>",
      "<space>s<space>",
      "<space>sq",
      "<space>cl",

      { "<space>rs", "<cmd>IronRepl<cr>" },
      { "<space>rr", "<cmd>IronRestart<cr>" },
      { "<space>rf", "<cmd>IronFocus<cr>" },
      { "<space>rh", "<cmd>IronHide<cr>" },
    },
    config = function()
      local iron = require "iron.core"
      local options = require "configs.iron.options"
      iron.setup(options)
    end,
  },

  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      require "configs.orgmode"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "python",
        "scheme",
        "org",
      },
    },
  },
}
