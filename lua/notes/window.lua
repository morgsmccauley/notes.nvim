local M = {}

local scratch_count = 0

local function get_config()
  return require("notes").get_config()
end

local function open_split(buf)
  vim.cmd("botright split")
  vim.api.nvim_win_set_buf(0, buf)
  local height = math.ceil(vim.o.lines / 3)
  vim.api.nvim_win_set_height(0, height)
end

local function setup_scratch_buffer(buf)
  local config = get_config()

  vim.bo[buf].buftype = "acwrite"
  vim.bo[buf].filetype = config.filetype
  vim.bo[buf].swapfile = false

  vim.api.nvim_create_autocmd("BufWriteCmd", {
    buffer = buf,
    callback = function()
      local timestamp = os.date("%Y-%m-%d_%H-%M-%S")
      vim.ui.input({ prompt = "Name (optional, prefix: " .. timestamp .. "): " }, function(input)
        if input == nil then
          return -- cancelled
        end

        local filename
        if input == "" then
          filename = timestamp .. "." .. config.filetype
        else
          filename = timestamp .. "_" .. input .. "." .. config.filetype
        end

        local filepath = config.dir .. "/" .. filename
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        vim.fn.writefile(lines, filepath)

        -- Convert to normal file buffer
        vim.bo[buf].buftype = ""
        vim.api.nvim_buf_set_name(buf, filepath)
        vim.bo[buf].modified = false

        vim.notify("Saved: " .. filepath)
      end)
    end,
  })
end

function M.open_scratch()
  scratch_count = scratch_count + 1
  local buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_buf_set_name(buf, "[scratch-" .. scratch_count .. "]")

  setup_scratch_buffer(buf)
  open_split(buf)
end

function M.open_file(filepath)
  local buf = vim.fn.bufnr(filepath, true)
  vim.bo[buf].filetype = get_config().filetype
  open_split(buf)
  vim.cmd("edit " .. vim.fn.fnameescape(filepath))
end

return M
