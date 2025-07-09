-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

-- latex
lspconfig.texlab.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

-- golang
lspconfig.gopls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

-- python
-- lspconfig.basedpyright.setup {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
-- }

-- python with poetry virtual environment support
-- local util = require "lspconfig/util"

-- local path = util.path

-- local function get_python_path(workspace)
--   -- Use activated virtualenv.
--   if vim.env.VIRTUAL_ENV then
--     return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
--   end
--
--   -- Find and use virtualenv via poetry in workspace directory.
--   local match = vim.fn.glob(path.join(workspace, "poetry.lock"))
--   if match ~= "" then
--     local venv = vim.fn.trim(vim.fn.system("poetry --directory " .. workspace .. " env info -p"))
--     return path.join(venv, "bin", "python")
--   end
--
--   -- Fallback to system Python.
--   return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
-- end
--
-- require("lspconfig").basedpyright.setup {
--   on_attach = function()
--     require("lsp_signature").on_attach {
--       hint_enable = false,
--     }
--   end,
--   on_init = function(client)
--     client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
--   end,
-- }
