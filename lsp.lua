-- local capabilities = require("blink.cmp").get_lsp_capabilities()

-- -- JavaScript/TypeScript
-- vim.lsp.config.tsserver = {
--   cmd = require('lspconfig.server_configurations.tsserver').default_config.cmd,
--   capabilities = capabilities,
-- }

-- -- Lua
-- vim.lsp.config.lua_ls = {
--   cmd = require('lspconfig.server_configurations.lua_ls').default_config.cmd,
--   capabilities = capabilities,
-- }

-- -- ESLint
-- vim.lsp.config.eslint = {
--   cmd = require('lspconfig.server_configurations.eslint').default_config.cmd,
--   capabilities = capabilities,
-- }

-- -- Start all configured servers automatically
-- for name, config in pairs(vim.lsp.config) do
--   vim.lsp.start(config)
-- end
