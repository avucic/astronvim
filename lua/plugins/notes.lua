return {
  -- "freitass/todo.txt-vim",
  {
    init = function() vim.g.todo_root = "~/Dropbox/todo" end,
    "elentok/todo.vim",
    cmd = { "Todo" },
  },
}
