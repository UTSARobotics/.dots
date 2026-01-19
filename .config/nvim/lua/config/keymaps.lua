-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Harpoon
vim.keymap.set("n", "<leader>a", function()
  require("harpoon.mark").add_file()
end)
vim.keymap.set("n", "<leader>s", function()
  require("harpoon.ui").toggle_quick_menu()
end)
vim.keymap.set("n", "<leader>1", function()
  require("harpoon.ui").nav_file(1)
end)
vim.keymap.set("n", "<leader>2", function()
  require("harpoon.ui").nav_file(2)
end)

--  Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
