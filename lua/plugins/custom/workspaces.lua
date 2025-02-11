local M = {}

local data_path = vim.fn.stdpath "data"
local cache_config = string.format("%s/workspaces.json", data_path)
local Path = require "plenary.path"

M.read_file = function() return vim.json.decode(Path:new(cache_config):read()) end

local function file_exists()
  if Path:new(cache_config):is_file() == nil then return false end
  return true
end

local function project_exists()
  if not file_exists() then return false end
  return true
end

function M.setup() M.init_cache_config() end

function M.init_cache_config()
  if not project_exists() then M.save_cache_file {} end
end

return M
