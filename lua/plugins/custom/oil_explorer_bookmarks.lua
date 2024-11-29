local M = {}

local actions = require "telescope.actions"
local state = require "telescope.actions.state"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"

local data_path = vim.fn.stdpath "data"
local cache_config = string.format("%s/oil-bookmarks.json", data_path)
local Path = require "plenary.path"

local function project_key() return vim.loop.cwd() end
local function read_file() return vim.json.decode(Path:new(cache_config):read()) end
local function is_project_exists()
  local key = project_key()

  if not Path:new(cache_config):is_file() then return false end

  local data = read_file()
  if data[key] == nil then return false end
  return true
end

function M.setup()
  if not is_project_exists() then M.save_cache_file {} end
  vim.api.nvim_create_user_command("OilBookmarks", M.open_bookmarks, { desc = "Open explorer with bookmarks" })
end

function M.init_cache_config()
  if not is_project_exists() then M.save_cache_file {} end
end

local function get_bookmarks()
  local data = read_file()
  local key = project_key()
  return data[key]
end

local function indexOf(array, value)
  for i, v in ipairs(array) do
    if v == value then return i end
  end
  return nil
end

function M.save_cache_file(bookmarks)
  local key = project_key()
  local data = read_file()
  data[key] = bookmarks or {}

  Path:new(cache_config):write(vim.fn.json_encode(data), "w")
end

function M.bookmark_index(path)
  local bookmarks = get_bookmarks()

  for i, v in ipairs(bookmarks) do
    if v == path then return i end
  end
  return nil
end

function M.create_bookmark(path)
  M.init_cache_config()

  local bookmarks = get_bookmarks()
  local index = indexOf(bookmarks, path)

  if index == nil then table.insert(bookmarks, path) end
  M.save_cache_file(bookmarks)
end

function M.delete_bookmark(path)
  M.init_cache_config()

  local bookmarks = get_bookmarks()
  local index = indexOf(bookmarks, path)

  if index then table.remove(bookmarks, index) end

  M.save_cache_file(bookmarks)
end

function M.open_bookmarks(opts)
  M.init_cache_config()

  opts = opts or {}

  local function build_results()
    local bookmarks = get_bookmarks()
    table.insert(bookmarks, 1, "/")
    return bookmarks
  end

  local results = build_results()

  pickers
    .new(opts, {
      prompt_title = "colors",
      finder = finders.new_table {
        results = results,
      },
      -- sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = state.get_selected_entry()
          local path = selection[1]
          if path == "/" then
            require("oil").toggle_float(vim.fn.getcwd())
          else
            require("oil").toggle_float(path)
          end
        end)

        local function delete_entry()
          local selection = state.get_selected_entry()
          local path = selection[1]

          if path == "/" then return end

          M.delete_bookmark(path)

          local current_picker = state.get_current_picker(prompt_bufnr)
          current_picker:refresh(finders.new_table(build_results()))
        end

        map("i", "d", delete_entry)
        map("n", "d", delete_entry)

        return true
      end,
    })
    :find()
end

return M
