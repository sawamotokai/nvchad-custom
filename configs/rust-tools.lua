local on_attach = require("plugins.configs.lspconfig").on_attach

return {
  server = {
    on_attach = on_attach,
  },
}
