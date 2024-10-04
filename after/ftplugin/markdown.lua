local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<cr>", function() vim.lsp.buf.definition() end, { desc = "Go to reference", buffer = bufnr })
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "Preview note", buffer = bufnr })
vim.keymap.set("n", "<Leader>mp", "<cmd>MarkdownPreview<cr>", { desc = "Preview in browser", buffer = bufnr })
vim.keymap.set("n", "<Leader>muc", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle conceal", buffer = bufnr })
