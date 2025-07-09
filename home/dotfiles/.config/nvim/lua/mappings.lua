require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- LazyGit
map("n", "<leader>lg", "<CMD> LazyGit<CR>", { desc = "open git interface" })

-- iron REPL
map("n", "<space>rs", "<cmd>IronRepl<cr>", { desc = "open REPL" })
map("n", "<space>rr", "<cmd>IronRestart<cr>", { desc = "restart REPL" })
map("n", "<space>rf", "<cmd>IronFocus<cr>", { desc = "focus REPL" })
map("n", "<space>rh", "<cmd>IronHide<cr>", { desc = "hide REPL" })

-- molten-nvim
-- map("n", "<localleader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
-- map("n", "<localleader>e", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "run operator selection" })
-- map("n", "<localleader>rl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
-- map("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate cell" })
-- map("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", { silent = true, desc = "evaluate visual selection" })
