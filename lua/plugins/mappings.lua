-- stylua: ignore start

vim.cmd [[vnoremap <C-r> "hy:%s@<C-r>h@@gI<left><left><left>]]
vim.cmd [[vnoremap <C-g> "hy:g/<C-r>h/normal<space>]]
-- vim.cmd([[vnoremap <C-r> "hy:Subs/<C-r>h//gI<left><left><left>]])
-- vim.cmd([[nnoremap <Leader-r> :%s/\<<C-r><C-w>\>/]])

-- command line
vim.cmd [[
  cnoremap <C-A> <Home>
	cnoremap <C-F> <Right>
	cnoremap <C-B> <Left>
  ]]

local maps = { i = {}, n = {}, v = {}, t = {}, x = {} }

-- N ------------------------------------------------------------------------------------
maps.n["<Leader>c"] = false -- close buffer
maps.n["<Leader>C"] = false
maps.n["<c-z>"] = "<Nop>"
maps.n["<C-q>"] = false
-- maps.n["gd"] = false
-- maps.n["gD"] = false
maps.n["|"] = false

maps.n["<c-q>"] =      { "<cmd>silent! cclose<cr><cmd>nohlsearch<cr><cmd>ToggleTermToggleAll<cr>" }
maps.n["<esc>"] =      { "<cmd>nohlsearch<cr><cmd>lua require('notify').dismiss()<cr>" }
maps.n["<esc><esc>"] = { "<cmd>nohlsearch<cr><cmd>lua require('notify').dismiss()<cr>" }
maps.n["Q"] =          { "<cmd>qall!<cr>" }
maps.n["<S-l>"] =      { "$" }
maps.n["<S-h>"] =      { "^" }
maps.n["z="] =         { "<cmd>lua require('telescope.builtin').spell_suggest()<CR>" }
maps.n["<Leader>W"] =  { "<cmd>:noa w<cr>", desc = "Save without format" }
-- maps.n["gV"] =      { "<cmd>lua require('tsht').nodes()<cr>" }
maps.v["<c-f>"] =      { "y<ESC>:lua require('telescope.builtin').live_grep({default_text= vim.fn.getreg('*')})<CR>" }
maps.v["gVa"] = maps.n["gVa"]
maps.v["gVd"] = maps.n["gVd"]
maps.v["<S-l>"] =      { "$", desc = "Jump to end of line" }
maps.v["<S-h>"] =      { "^", desc = "Jump to the begging of line" }
maps.v["p"] =          { '"_dP' }
-- maps.v["gV"] = { "<cmd>lua require('tsht').nodes()<cr>" }

-- remove from Astrovim. TODO: better way?
maps.n["<A-j>"] = { "<Nop>" }
maps.n["<A-k>"] = { "<Nop>" }

-- c-w  +Windows
maps.n["<c-w>q"] = { "<cmd>:q<cr>", desc = "Close" }
maps.n["<c-w>D"] = { "<cmd>only<cr>", desc = "Close others" }
maps.n["<C-w>K"] = { "<cmd>lua require('smart-splits').resize_up()<cr><cmd>WhichKey <c-w><cr>", desc = "Resize split up" }
maps.n["<C-w>J"] = { "<cmd>lua require('smart-splits').resize_down()<cr><cmd>WhichKey <c-w><cr>", desc = "Resize split down" }
maps.n["<C-w>H"] = { "<cmd>lua require('smart-splits').resize_left()<cr><cmd>WhichKey <c-w><cr>", desc = "Resize split left" }
maps.n["<C-w>L"] = { "<cmd>lua require('smart-splits').resize_right()<cr><cmd>WhichKey <c-w><cr>", desc = "Resize split right" }

-- tabs
maps.n["<c-w>t"] = { desc = "Tabs" }
maps.n["<c-w>tt"] = { "<cmd>lua require('telescope-tabs').list_tabs()<cr>", desc = "List tabs" }
maps.n["<c-w>tn"] = { "<cmd>tabnew<cr>", desc = "new tab" }
maps.n["<c-w>tq"] = { "<cmd>tabclose<cr>", desc = "Close tab" }

-- +Files
maps.n["<Leader>fn"] = { "<cmd>enew<cr>", desc = "New file" }
maps.n["<Leader>fe"] = { "<cmd>lua _VIFM_TOGGLE()<cr>", desc = "Explorer from current dir" }
maps.n["<Leader>fE"] = { "<cmd>lua _VIFM_TOGGLE(vim.fn.getcwd())<cr>", desc = "Explorer from current dir" }
maps.n["<Leader>fd"] = { "<cmd>lua require('telescope').extensions.dir.live_grep()<CR>", desc = "Find dir" }
maps.n["<Leader>f?"] = { "<cmd>lua require('telescope.builtin').search_history()<CR>", desc = "History" }
maps.n["<Leader>fy"] = { "<cmd>let @*=expand('%')<cr>", desc = "Yank file path" }
maps.n["<Leader>fY"] = { "<cmd>let @*=expand('%:p')<cr>", desc = "Yank full file path" }
maps.n["<Leader>fx"] = { "<cmd>OpenFile<cr>", desc = "Open file in folder" }
maps.n["<Leader>fX"] = { "<cmd>OpenFolderInFinder<cr>", desc = "Open folder" }
maps.v["<leader>fw"] = { "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({default_text = require('core.utils').get_visual_selection()})<CR>", desc = "Live grep", }
maps.n["<Leader>fC"] = false

-- +Search
maps.n["<Leader>s"] = { desc = "Search" }
maps.n["<leader>sc"] = { "<cmd>lua require('telescope.builtin').commands()<CR>", desc = "Commands" }
maps.n["<Leader>s;"] = { "<cmd>lua require('telescope.builtin').command_history()<CR>", desc = "Command History" }
maps.n["<Leader>st"] = { "<cmd>TodoTelescope<cr>", desc = "Todo list" }
maps.n["<leader>sb"] = { "<cmd>lua require('telescope.builtin').buffers()<CR>", desc = "Buffers" }
maps.n["<Leader>sn"] = { function() require("telescope").extensions.notify.notify() end, desc = "Find notifications" }
maps.n["<leader>s<cr>"] = { "<cmd>lua require('telescope.builtin').resume()<CR>", desc = "Resume" }
-- maps.n["<leader>sh"] = { "<cmd>lua require('telescope.builtin').help_tags()<CR>", desc = "Help" }
-- maps.n["<leader>sk"] = { "<cmd>lua require('telescope.builtin').keymaps()<CR>", desc = "Keymaps" }
-- maps.n["<leader>sO"] = { "<cmd>lua require('telescope.builtin').vim_options()<CR>", desc = "Options" }
-- maps.n["<leader>s;"] = { "<cmd>lua require('telescope.builtin').command_history()<CR>", desc = "History" }

-- +Buffers
maps.n["<Leader>bo"] = { "<Leader>bc", desc = "Close all buffers except current", remap = true }
maps.n["<Leader>bO"] = { "<Leader>bC", desc = "Close all", remap = true }
maps.n["<Leader>bL"] = { function() require("astrocore.buffer").close_left() end, desc = "Close all buffers to the left" }
maps.n["<Leader>bR"] = { function() require("astrocore.buffer").close_right() end, desc = "Close all buffers to the right" }
maps.n["<Leader>br"] = false
maps.n["<leader>bl"] = { "<cmd>lua require('astrocore.buffer').nav((vim.v.count > 0 and vim.v.count or 1))<cr><cmd>WhichKey <LT>leader>b<CR>", desc = "Next buffer", }
maps.n["<leader>bh"] = { "<cmd>lua require('astrocore.buffer').nav(-(vim.v.count > 0 and vim.v.count or 1))<cr><cmd>WhichKey <LT>leader>b<CR>", desc = "Previous buffer", }
maps.n["<leader>bq"] = { "<cmd>lua require('astrocore.buffer').close(0)<CR><cmd>WhichKey <LT>leader>b<CR>", desc = "Close" }
maps.n["<leader>bQ"] = { "<cmd>q<cr>", desc = "Force close", }

-- maps.n["<Leader>bc"] = false
-- maps.n["<Leader>bC"] = false
-- maps.n["<Leader>bb"] = false

-- maps.n["<Leader>bb"] = { "<cmd>lua require('telescope.builtin').buffers()<CR>", desc = "History" }
-- maps.n["<Leader>bo"] = { function() require("astronvim.utils.buffer").close_all(true) end, desc = "Close all buffers except current" }
-- maps.n["<Leader>bl"] = {
--   "<cmd>lua require('astronvim.utils.buffer').nav((vim.v.count > 0 and vim.v.count or 1))<cr><cmd>WhichKey <LT>leader>b<CR>",
--   desc = "Next buffer",
-- }
-- maps.n["<Leader>bh"] = {
--   "<cmd>lua require('astronvim.utils.buffer').nav(-(vim.v.count > 0 and vim.v.count or 1))<cr><cmd>WhichKey <LT>leader>b<CR>",
--   desc = "Previous buffer",
-- }
-- maps.n["<Leader>bp"] = {
--   "<cmd>lua require('astronvim.utils.status').heirline.buffer_picker(function(bufnr) vim.api.nvim_win_set_buf(0, bufnr) end)<CR>",
--   desc = "Pick",
-- }
-- maps.n["<Leader>bq"] =
--   { "<cmd>lua require('astronvim.utils.buffer').close(0)<CR><cmd>WhichKey <LT>leader>b<CR>", desc = "Close" }
-- maps.n["<Leader>bQ"] = { "<cmd>q<cr>", desc = "Force close" }
-- maps.n["<Leader>b-"] = {
--   "<cmd>lua require('astronvim.utils.status').heirline.buffer_picker(function(bufnr) vim.cmd.split() vim.api.nvim_win_set_buf(0, bufnr) end)<CR>",
--   desc = "Split horizontally",
-- }

-- +Git
maps.n["<Leader>gf"] = { "<cmd>Easypick changed_files<cr>", desc = "List changed files" }
maps.n["<Leader>gr"] = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset hunk" }
maps.n["<Leader>gR"] = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset buffer" }
-- maps.n["<Leader>gO"] = { "<cmd>OpenInGHFile<cr>", desc = "Open current file in Github" }
-- maps.n["<Leader>go"] = { "<cmd>OpenInGHRepo<cr>", desc = "Open page with line in Github" }
maps.n["<Leader>gs"] = {
  "<cmd>lua _LAZYGIT_TOGGLE()<CR>",
  desc = "Git status",
}

maps.n["<Leader>gd"] = { false, desc = "Git diff" }
maps.n["<Leader>gdd"] = { "<cmd>lua require('gitsigns').diffthis()<cr>", desc = "Diff" }
maps.n["<Leader>gdq"] = { "<cmd>diffoff<cr>", desc = "Diff" }
maps.n["<Leader>gdl"] = { "<cmd>lua require('telescope').extensions.advanced_git_search.diff_commit_line()<cr>", desc = "Search line" }
maps.v["<leader>gdl"] = { "<cmd>lua require('telescope').extensions.advanced_git_search.diff_commit_line()<cr>", desc = "Search line" }
maps.n["<Leader>gdb"] = { "<cmd>lua require('telescope').extensions.advanced_git_search.diff_branch_file()<cr>", desc = "Diff branch file" }
maps.n["<Leader>gdf"] = { "<cmd>lua require('telescope').extensions.advanced_git_search.diff_commit_file()<cr>", desc = "Search file" }
maps.n["<Leader>gds"] = { "<cmd>lua require('telescope').extensions.advanced_git_search.search_log_content()<cr>", desc = "Search log" }
maps.n["<Leader>gt"] = false
maps.n["<Leader>gS"] = false
--
-- +Open
maps.n["<Leader>o"] = { false, desc = "Open" }

-- +Tasks
maps.n["<Leader>t"] = { desc = "Tasks" }
maps.n["<Leader>tf"] = false
maps.n["<Leader>th"] = false
maps.n["<Leader>tl"] = false
maps.n["<Leader>tn"] = false
maps.n["<Leader>tp"] = false
maps.n["<Leader>tv"] = false

-- + Run
-- maps.n["<Leader>rf"] = { "<cmd>FlowRunFile<cr>", desc = "Run file" }
-- maps.n["<Leader>r;"] = { "<cmd>FlowLauncher<cr>", desc = "Run launcher" }
-- maps.n["<Leader>rl"] = { "<cmd>FlowRunLastCmd<cr>", desc = "Run last command" }
-- maps.n["<Leader>ro"] = { "<cmd>FlowLastOutput<cr>", desc = "Run last output" }

-- +Jump
maps.n["<Leader>j"] = { desc = "Jumping" }
maps.n["<Leader>jn"] = { "<cmd>lua require('aerial').next()<cr><cmd>WhichKey <LT>leader>j<CR>", desc = "Aerial next" }
maps.n["<Leader>jN"] = { "<cmd>lua require('aerial').next(-1)<cr><cmd>WhichKey <LT>leader>j<CR>", desc = "Aerial previous" }
maps.n["<Leader>jr"] = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", desc = "LSP references" }

-- +Notes
maps.n["<Leader>n"] = { false, desc = "Notes" }
maps.n["<Leader>nn"] = false
maps.n["<Leader>no"] = { "<Cmd>ZkOpenNotes<CR>", desc = "Open notes" }
maps.n["<Leader>ni"] = { "<cmd>ZkOpenNotebook<CR>", desc = "Open notebook" }
maps.n["<Leader>n."] = { "<Cmd>ZkCd<CR>", desc = "cdw" }
maps.n["<Leader>nR"] = { "<Cmd>ZkIndex<CR>", desc = "Reindex" }
maps.n["<Leader>nc"] = { "<cmd>ZkShowCalendar<cr>", desc = "Calendar" }
maps.n["<Leader>nnr"] = { "<cmd>:ZkFindOrCreateNote { group='reference_notes', dir='references'}<cr>", desc = "Reference note" }
maps.n["<Leader>nns"] = { "<cmd>:ZkFindOrCreateNote { group='permanent_notes', dir='slip-box'}<cr>", desc = "Slip note" }
maps.n["<Leader>nnd"] = { "<cmd>:ZkFindOrCreateNote { group='fleeting_notes', dir='dalily_notes'}<cr>", desc = "Daily note" }
maps.n["<Leader>nnl"] = { "<cmd>:ZkFindOrCreateNote { group='literature_notes', dir='literature_notes'}<cr>", desc = "Literature note" }
maps.n["<Leader>nnp"] = { "<cmd>:ZkFindOrCreateProjectNote<cr>", desc = "Project note" }
maps.n["<Leader>ntt"] = { "<cmd>lua _TASKS_TOGGLE()<CR>", desc = "Tasks today" }

maps.n["<Leader>nfg"] = { "<Cmd>ZkGrep<CR>", desc = "Grep" }
maps.n["<Leader>nft"] = { "<Cmd>ZkTags<CR>", desc = "By tags" }
maps.n["<Leader>nfl"] = { "<Cmd>ZkTags<CR>", desc = "Links" }
maps.n["<Leader>nfb"] = { "<Cmd>ZkTags<CR>", desc = "Backlinks" }
maps.n["<Leader>nfo"] = { "<Cmd>ZkTags<CR>", desc = "Orphans" }

maps.n["<Leader>njd"] = { "<cmd>ZkFindOrCreateJournalDailyNote<cr>", desc = "New dalily journal" }
maps.n["<Leader>njf"] = { "<cmd>ZkNew{group='fer', dir='journal/fer'}<cr>", desc = "New fer session" }
maps.n["<Leader>ns"] = { "<cmd>lua _SCRATCHPAD_TOGGLE()<cr>", desc = "Scratch Pad" }

-- +Toggle
-- maps.n["<Leader>ub"] = { "<cmd>lua require('user.core.utils').toggle_theme()<cr>", desc = "Toggle theme" }
-- maps.n["<Leader>ux"] = { "<cmd>lua require('user.core.utils').toggle_lsp_virtual_text_popup()<cr>", desc = "Toggle Lsp virtual text popup" }
-- maps.n["<Leader>uo"] = { "<cmd>lua require('aerial').toggle()<cr>", desc = "Outline" }

-- +Text
maps.n["<Leader>x"] = { desc = "Text" }
maps.v["<Leader>x"] = { desc = "Text" }
maps.v["<Leader>xa"] = { desc = "Align" }
maps.n["<Leader>xi"] = { desc = "Text Case" }
maps.n["<Leader>xi."] = { "<cmd>TextCaseOpenTelescope<CR>", desc = "Current word" }
maps.n["<Leader>xiq"] = { "<cmd>TextCaseOpenTelescopeQuickChange<CR>", desc = "Telescope Quick Change" }
maps.n["<Leader>xil"] = { "<cmd>TextCaseOpenTelescopeLSPChange<CR>", desc = "Telescope LSP Change" }
maps.n["<Leader>xr"] = { [[:%s/\<<C-r><C-w>\>/]], desc = "Replace" }

-- +Yank
-- maps.n["<Leader>yy"] = { "<cmd>lua require('telescope').extensions.neoclip.default()<cr>", desc = "History" }
maps.n["<Leader>y"] = { desc = "Yank" }
maps.v["<Leader>y"] = { desc = "Yank" }
maps.n["<Leader>yy"] = { "<cmd>lua require('telescope').extensions.yank_history.yank_history()<cr>", desc = "History" }
maps.n["<Leader>ym"] = { "<cmd>lua require('telescope').extensions.macroscope.default()<cr>", desc = "Macro history" }
maps.n["<Leader>yD"] = { "<cmd>lua require('neoclip').clear_history()<cr>", desc = "Clear history" }
maps.v["<leader>yy"] = { "<cmd>lua require('telescope').extensions.yank_history.yank_history()<cr>", desc = "History" }

-- Leap
maps.n["s"] = { "<cmd>lua require('leap')<cr><Plug>(leap-forward-to)" }
maps.n["S"] = { "<cmd>lua require('leap')<cr><Plug>(leap-backward-to)" }
maps.n["gs"] = "<cmd>lua require('leap')<cr><Plug>(leap-from-window)"
maps.n["<M-s>"] = { "<cmd>lua require('user.plugins.configs.leap').paranormal()<cr>" }

-- T ------------------------------------------------------------------------------------
maps.t["\\\\"] = { "<cmd>ToggleTermToggleAll<cr>" }
maps.t["<c-q>"] = { "<C-\\><C-n>" }

maps.t["<C-h>"] = false
maps.t["<C-j>"] = false
maps.t["<C-k>"] = false
maps.t["<C-l>"] = false
-- stylua: ignore end

return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = maps,
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      maps = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          K = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}
