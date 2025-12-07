local window = require("notes.window")

local M = {}

local config = {
  dir = "~/.notes",
  filetype = "md",
}

function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})
  config.dir = vim.fn.expand(config.dir)
  vim.fn.mkdir(config.dir, "p")
end

function M.get_config()
  return config
end

function M.new()
  window.open_scratch()
end

function M.open(name)
  if name and name ~= "" then
    local filepath = config.dir .. "/" .. name
    if not name:match("%." .. config.filetype .. "$") then
      filepath = filepath .. "." .. config.filetype
    end
    window.open_file(filepath)
  else
    -- Open most recent note
    local files = vim.fn.glob(config.dir .. "/*." .. config.filetype, false, true)
    if #files == 0 then
      vim.notify("No notes found", vim.log.levels.WARN)
      return
    end
    table.sort(files, function(a, b)
      return vim.fn.getftime(a) > vim.fn.getftime(b)
    end)
    window.open_file(files[1])
  end
end

return M
