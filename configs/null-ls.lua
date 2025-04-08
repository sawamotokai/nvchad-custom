local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local b = null_ls.builtins

local sources = {
  -- webdev stuff
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes
  b.code_actions.ts_node_action,

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,
  -- golang
  -- b.formatting.gofumpt,
  b.formatting.goimports_reviser,
  b.formatting.golines.with {
    extra_args = {
      "--max-len=180",
      "--base-formatter=gofumpt",
    },
  },
  b.diagnostics.revive,
}

-- autosave
null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}
