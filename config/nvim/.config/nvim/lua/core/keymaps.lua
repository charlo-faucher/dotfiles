-- lua/core/keymaps.lua
local map = vim.keymap.set
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Explorer" })
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })

