vim.api.nvim_create_user_command("NotesNew", function()
  require("notes").new()
end, { desc = "Open a new scratch note" })

vim.api.nvim_create_user_command("NotesOpen", function(opts)
  require("notes").open(opts.args)
end, { nargs = "?", desc = "Open an existing note" })
