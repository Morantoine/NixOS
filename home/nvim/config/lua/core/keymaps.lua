local keymap = vim.keymap
vim.g.mapleader = ","

-- move up/down the page and stay centered
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- navigate quickfix
keymap.set("n", "]c", "<cmd>cnext<CR>")
keymap.set("n", "[c", "<cmd>cprev<CR>")

-- manage splits
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- manage tabs
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current buffer" })
keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<tab>", "<cmd>tabnext<CR>", { desc = "Go to next buffer" })
keymap.set("n", "<s-tab>", "<cmd>tabprevious<CR>", { desc = "Go to previous buffer" })
