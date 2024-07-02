local astrocore = require "astrocore"
local mappings = astrocore.config.mappings
if mappings == nil then return end

mappings.n["<cr>"] = {
  function() vim.lsp.buf.definition() end,
  desc = "Go to reference",
}
mappings.n["K"] = {
  function() vim.lsp.buf.hover() end,
  desc = "Preview note",
}

astrocore.set_mappings(mappings, {})
