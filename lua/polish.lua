-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
    mdx = "markdown",
    mjml = "eruby",
    cedarschema = "cedar",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
    [".env.*"] = "sh",
    ["vifmrc"] = "vim",
  },
}

vim.filetype.add {
  extension = {
    cedar = "cedar",
  },
}

local ft = require "Comment.ft"
ft.set("cedar", { "//%s" })

vim.opt.conceallevel = 3
vim.opt.foldenable = false
vim.opt.spell = true
