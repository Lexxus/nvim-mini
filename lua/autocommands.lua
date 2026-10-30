-- refresh a buffer on focus
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
  pattern = "*",
  command = "checktime",
})
