---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<C-y>"] = { 'gg"+yG', "Test current cpp file in terminal" },
  },
}

M.telescope = {
  n = {
    ["<leader>c"] = { "<cmd>Telescope commands<CR>", "Command" },
    ["<leader>ff"] = { "<cmd>Telescope find_files<CR>", "Command" },
  },
}

M.dap = {
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Toggle breakpoint",
    },
    ["<leader>di"] = {
      function()
        require("dap").step_into()
      end,
      "Step into",
    },
    ["<leader>do"] = {
      function()
        require("dap").step_out()
      end,
      "Step into",
    },
    ["<leader>dn"] = {
      function()
        require("dap").step_over()
      end,
      "Next line",
    },
    ["<leader>dt"] = {
      function()
        require("dap").terminate()
      end,
      "Terminate",
    },
    ["<leader>dr"] = {
      function()
        require("dap").restart_frame()
      end,
      "Restart",
    },
    ["<leader>dv"] = {
      function()
        require("dapui").eval()
      end,
      "Value under cursor",
    },
    ["<leader>dc"] = {
      function()
        require("dap").continue()
      end,
      "Continue program",
    },
    ["<leader>du"] = {
      function()
        require("dapui").toggle()
      end,
      "Toggle dap UI",
    },
  },
}

M.dap_go = {
  n = {
    ["<leader>dgt"] = {
      function()
        require("dap-go").debug_test()
      end,
      "Run go test under cursor",
    },
    ["<leader>dgl"] = {
      function()
        require("dap-go").debug_last()
      end,
      "Rerun last go test",
    },
  },
}

M.trouble = {
  n = {
    ["<leader>tt"] = {
      function()
        require("trouble").toggle()
      end,
      "Trouble",
    },
    ["<leader>tw"] = {
      function()
        require("trouble").toggle "workspace_diagnostics"
      end,
      "Workspace",
    },
    ["<leader>td"] = {
      function()
        require("trouble").toggle "document_diagnostics"
      end,
      "Document",
    },
    ["<leader>tq"] = {
      function()
        require("trouble").toggle "quickfix"
      end,
      "Quick fix",
    },
    ["<leader>tl"] = {
      function()
        require("trouble").toggle "loclist"
      end,
      "Location list",
    },
    ["<leader>tr"] = {
      function()
        require("trouble").toggle "lsp_references"
      end,
      "References",
    },
  },
}

-- more keybinds!
M.custom = {
  n = {
    ["<leader>dr"] = { "<cmd>vs<CR><cmd>term cprun %:t:r<CR>", "Test current cpp file in terminal" },
    ["<leader>?"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },
    ["<leader>wt"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },
  },
  c = {
    ["<C-j>"] = { "<C-n>", "Navigate down in command mode" },
    ["<C-k>"] = { "<C-p>", "Navigate up in command mode" },
  },
}

M.chatgpt = {
  n = {
    -- A as in AI
    ["<leader>ac"] = { "<cmd>ChatGPT<CR>", "ChatGPT" },
    ["<leader>ae"] = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
    ["<leader>ag"] = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
    ["<leader>at"] = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
    ["<leader>ak"] = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
    ["<leader>ad"] = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
    ["<leader>aa"] = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
    ["<leader>ao"] = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
    ["<leader>as"] = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
    ["<leader>af"] = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
    ["<leader>ax"] = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
    ["<leader>ar"] = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
    ["<leader>al"] = {
      "<cmd>ChatGPTRun code_readability_analysis<CR>",
      "Code Readability Analysis",
      mode = { "n", "v" },
    },
  },
}

M.lsp = {
  n = {
    ["gR"] = { "<cmd>Telescope lsp_references<CR>", "Find code references" },
    ["gD"] = { vim.lsp.buf.declaration, "Find code declaration" },
    ["gd"] = { "<cmd>Telescope lsp_definitions<CR>", "Find code definition" },
    ["gi"] = { "<cmd>Telescope lsp_implementations<CR>", "Find code implementations" },
    ["gt"] = { "<cmd>Telescope lsp_type_definitions<CR>", "Find type definitions" },
    ["<leader>lgR"] = { "<cmd>Telescope lsp_references<CR>", "Find code references" },
    ["<leader>lgD"] = { vim.lsp.buf.declaration, "Find code declaration" },
    ["<leader>lgd"] = { "<cmd>Telescope lsp_definitions<CR>", "Find code definition" },
    ["<leader>lgi"] = { "<cmd>Telescope lsp_implementations<CR>", "Find code implementations" },
    ["<leader>lgt"] = { "<cmd>Telescope lsp_type_definitions<CR>", "Find type definitions" },
    ["<leader>lr"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },
    ["<leader>lD"] = { "<cmd>Telescope diagnostics bufnr=0<CR>", "Buffer diagnostics" },
    ["<leader>ld"] = { vim.diagnostic.open_float, "Line diagnostics" },
    ["<leader>la"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
  },
}

M.rust = {
  n = {
    ["<leader>rh"] = {
      function()
        require("rust-tools").hover_actions.hover_actions()
        require("rust-tools").hover_actions.hover_actions()
      end,
      "Rust hover action",
    },
  },
}

M.jump = {
  n = {
    ["<leader>jc"] = {
      function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd [[normal! _]]
        end
      end,

      "Jump to current context",
    },
  },
}

M.comment = {
  plugin = true,
  -- toggle comment in both modes
  n = {
    ["<C-/>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },
  i = {
    ["<C-/>"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
  v = {
    ["<C-/>"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.window = {
  n = {
    -- ["<leader>/"] = {
    --   "<cmd> vsplit <CR>",
    --   "Split Vertically",
    -- },
    -- ["<leader>-"] = {
    --   "<cmd> split <CR>",
    --   "Split horizontally",
    -- },
    ["<leader>W"] = {
      "<cmd>q <CR>",
      "Close window",
    },
  },
}

M.disabled = {
  n = {
    ["<leader>ra"] = "",
    ["<leader>cm"] = "",
    ["<leader>ca"] = "",
    ["<leader>cc"] = "",
    ["<leader>ch"] = "",
    ["<leader>th"] = "",
    -- ["<leader>/"] = "",
    ["<leader>b"] = "",
    ["<leader>ff"] = "",
  },

  v = {
    -- ["<leader>/"] = "",
  },
}

return M
