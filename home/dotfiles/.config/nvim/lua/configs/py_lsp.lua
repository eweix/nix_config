local options = {
  -- This is optional, but allows to create virtual envs from nvim
  host_python = "/bin/python",
  default_venv_name = ".venv", -- For local venv
}

require("py_lsp.nvim").setup(options)
