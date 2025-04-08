local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "nvimtools/none-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   ft = "go",
  --   config = function()
  --     return require "custom.configs.null-ls"
  --   end,
  -- },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "gopls",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    opts = {},
    event = "VeryLazy",
    config = function()
      local actions = require "ts-node-action.actions"
      local operators = {
        ["!="] = "==",
        ["!=="] = "===",
        ["=="] = "!=",
        ["==="] = "!==",
        [">"] = "<",
        ["<"] = ">",
        [">="] = "<=",
        ["<="] = ">=",
      }

      local padding = {
        [","] = "%s ",
        [":"] = "%s ",
        ["{"] = "%s ",
        ["}"] = " %s",
      }
      require("ts-node-action").setup {
        svelte = {
          ["property_identifier"] = actions.cycle_case(),
          ["string_fragment"] = actions.conceal_string(),
          ["attribute_value"] = actions.conceal_string(),
          ["attribute_name"] = actions.conceal_string(),
          ["binary_expression"] = actions.toggle_operator(operators),
          ["object"] = actions.toggle_multiline(padding),
          ["array"] = actions.toggle_multiline(padding),
          ["statement_block"] = actions.toggle_multiline(padding),
          ["object_pattern"] = actions.toggle_multiline(padding),
          ["object_type"] = actions.toggle_multiline(padding),
          ["formal_parameters"] = actions.toggle_multiline(padding),
          ["arguments"] = actions.toggle_multiline(padding),
          ["number"] = actions.toggle_int_readability(),
        },
      }
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      local cmp = require "cmp"
      table.insert(M.sources, { name = "crates" })
      table.insert(M.sources, { name = "parrot" })
      M.mapping["<C-k>"] = cmp.mapping.select_prev_item()
      M.mapping["<C-j>"] = cmp.mapping.select_next_item()
      M.mapping["<Tab>"] = nil
      M.mapping["<S-Tab>"] = nil
      return M
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local M = require "plugins.configs.telescope"
      M.defaults.mappings.i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
      }
      return M
    end,
  },

  {
    "folke/which-key.nvim",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup(opts)
      local present, wk = pcall(require, "which-key")
      if not present then
        return
      end
      wk.register {
        { "<leader>a", group = "AI" },
        { "<leader>d", group = "Dap" },
        { "<leader>dg", group = "Golang" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Golang" },
        { "<leader>j", group = "Jump" },
        { "<leader>l", group = "Lsp" },
        { "<leader>lg", group = "Go to" },
        { "<leader>m", group = "bookMark" },
        { "<leader>p", group = "Pick hidden term" },
        { "<leader>r", group = "Rust" },
        { "<leader>t", group = "Trouble" },
        { "<leader>w", group = "Workspace/Which-key" },
      }
    end,
    setup = function()
      require("core.utils").load_mappings "whichkey"
    end,
  },
  { "echasnovski/mini.icons", version = false },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  -- Install a plugin
  {
    "frankroeder/parrot.nvim",
    dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
    event = "VeryLazy",
    -- optionally include "folke/noice.nvim" or "rcarriga/nvim-notify" for beautiful notifications
    config = function()
      require("parrot").setup {
        -- Providers must be explicitly added to make them available.
        providers = {
          anthropic = {
            api_key = os.getenv "ANTHROPIC_API_KEY",
          },
          gemini = {
            api_key = os.getenv "GEMINI_API_KEY",
          },
          groq = {
            api_key = os.getenv "GROQ_API_KEY",
          },
          mistral = {
            api_key = os.getenv "MISTRAL_API_KEY",
          },
          pplx = {
            api_key = os.getenv "PERPLEXITY_API_KEY",
          },
          -- provide an empty list to make provider available (no API key required)
          ollama = {},
          openai = {
            api_key = os.getenv "OPENAI_API_KEY",
          },
          github = {
            api_key = os.getenv "GITHUB_TOKEN",
          },
          nvidia = {
            api_key = os.getenv "NVIDIA_API_KEY",
          },
          xai = {
            api_key = os.getenv "XAI_API_KEY",
          },
        },
        prompts = {
            ["Complete"] = "Continue the implementation of the provided snippet in the file {{filename}}." -- e.g., :'<,'>PrtAppend Complete
        },
        hooks = {
          CompleteFullContext = function(prt, params)
            local template = [[
            I have the following code from {{filename}}:

            ```{{filetype}}
            {{filecontent}}
            ```

            I have the following code from all open buffers:

            ```{{filetype}}
            {{multifilecontent}}
            ```

            Please look at the following section specifically if any:
            ```{{filetype}}
            {{selection}}
            ```

            Please finish the code above carefully and logically.
            Respond just with the snippet of code that should be inserted; no words exccept code.
            ]]
            local model_obj = prt.get_model("command")
            prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
          end,
        }
      }
    end,
  },
  --
  -- {
  --   "max397574/better-escape.nvim",
  --   event = "InsertEnter",
  --   config = function()
  --     require("better_escape").setup()
  --   end,
  -- },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  -- image viewer
  {
    "edluffy/hologram.nvim",
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  -- Flutter
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
  },

  -- Rust

  {
    -- autosave
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",

    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },

  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require "crates"
      crates.setup(opts)
      crates.show()
    end,
  },

  {
    'cordx56/rustowl',
    build = 'cd rustowl && cargo install --path . --locked',
    lazy = false, -- This plugin is already lazy
    opts = {
      client = {
        on_attach = function(_, buffer)
          vim.keymap.set('n', '<leader>o', function()
            require('rustowl').toggle(buffer)
          end, { buffer = buffer, desc = 'Toggle RustOwl' })
        end
      },
    },
  },

  -- Golang
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- Dap
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    init = function()
      require("core.utils").load_mappings "dap"
      local dap, dapui = require "dap", require "dapui"
      dapui.setup()
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings "dap_go"
    end,
  },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },

  -- Copilot
  { "github/copilot.vim", event = "VeryLazy" },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
