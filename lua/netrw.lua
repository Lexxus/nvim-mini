vim.g.netrw_liststyle = 3 -- treeview
vim.g.netrw_banner = 0
vim.g.netrw_winsize = -30 -- negative = absolute width in columns (positive = percentage)
vim.g.netrw_browse_split = 0 -- open files in the previous window
vim.g.netrw_altfile = 1 -- keep the alternate file correct

vim.keymap.set("n", "<leader>e", ":Lexplore<cr>", { silent = true })

