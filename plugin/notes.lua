vim.api.nvim_create_user_command("NotesNew", function()
  require("notes").new()
end, { desc = "Create a new scratch note" })

vim.api.nvim_create_user_command("NotesScratch", function()
  require("notes").scratch()
end, { desc = "Open existing scratch or create one" })

vim.api.nvim_create_user_command("NotesOpen", function(opts)
  require("notes").open(opts.args)
end, { nargs = "?", desc = "Open an existing note" })
