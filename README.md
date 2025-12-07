# notes.nvim

Simple, persistent notes for Neovim. Start with scratch notes, save what's worth keeping.

## Features

- Quick scratch notes that don't clutter your workspace
- Save notes when they become valuable
- Markdown by default
- Configurable storage locations

## Installation

```lua
-- lazy.nvim
{
  "morganmccauley/notes.nvim",
  config = function()
    require("notes").setup()
  end,
}
```

## Configuration

```lua
require("notes").setup({
  dir = "~/.notes",
  filetype = "md",
})
```

## Usage

### Commands

- `:NotesNew` - open a new scratch note
- `:NotesOpen [name]` - open an existing note (or create named note)
- `:NotesList` - list saved notes (by filename)
- `:NotesSearch [query]` - search note contents

Saving: just use `:w` - scratch notes are saved to `dir` when written.

### Keymaps (suggestions)

```lua
vim.keymap.set("n", "<leader>nn", "<cmd>NotesNew<cr>")
vim.keymap.set("n", "<leader>no", "<cmd>NotesOpen<cr>")
vim.keymap.set("n", "<leader>nl", "<cmd>NotesList<cr>")
vim.keymap.set("n", "<leader>ns", "<cmd>NotesSearch<cr>")
```

## License

MIT
