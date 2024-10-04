local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<cr>", function() vim.lsp.buf.definition() end, { desc = "Go to reference", buffer = bufnr })
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "Preview note", buffer = bufnr })
