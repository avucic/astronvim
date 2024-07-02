local astrocore = require "astrocore"
local mappings = astrocore.config.mappings
if mappings == nil then return end

mappings.n["<Leader>mK"] = { "<cmd>RustLsp openDocs<cr>", desc = "Open docs" }
mappings.n["<Leader>me"] = { "<cmd>RustLsp explainError<cr>", desc = "Explain error" }
mappings.n["<Leader>mc"] = { "<cmd>RustLsp openCargo<cr>", desc = "Open cargo" }
mappings.n["<Leader>mx"] = { "<cmd>RustLsp expandMacro<cr>", desc = "Expand macro" }
mappings.v["<Leader>mo"] = { "diOption<<esc>pa><esc>", desc = "Add option" }
mappings.v["<Leader>mO"] = { "diOption<<esc>pa><esc>", desc = "Remove option" }
mappings.v["<Leader>mr"] = { "diResult<<esc>pa><esc>", desc = "Add option" }
mappings.v["<Leader>mR"] = { "diResult<<esc>pa><esc>", desc = "Remove option" }
mappings.v["<Leader>ms"] = { "diSome(<esc>pa)<esc>", desc = "Add some" }

astrocore.set_mappings(mappings, {})
