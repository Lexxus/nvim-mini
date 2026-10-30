-- Move cursor between split buffers
vim.keymap.set("n", "<C-k>", ":wincmd k<cr>", { silent = true, desc="Move cursor to above split" })
vim.keymap.set("n", "<C-l>", ":wincmd l<cr>", { silent = true, desc="Move cursor to right split" })
vim.keymap.set("n", "<C-j>", ":wincmd j<cr>", { silent = true, desc="Move cursor to below split" })
vim.keymap.set("n", "<C-h>", ":wincmd h<cr>", { silent = true, desc="Move cursor to left split" })
-- netrw used <C-l> and <C-h>
vim.keymap.set("n", "<CS-l>", ":wincmd l<cr>", { silent = true, desc="Move cursor to right split" })
vim.keymap.set("n", "<CS-h>", ":wincmd h<cr>", { silent = true, desc="Move cursor to left split" })

vim.keymap.set("n", "]b", ":bn<cr>", { silent = true, desc="Next buffer" })
vim.keymap.set("n", "[b", ":bp<cr>", { silent = true, desc="Prev buffer" })
