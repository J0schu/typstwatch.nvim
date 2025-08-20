# typstwatch.nvim

`typstwatch.nvim` provides a minimal, low-overhead way to automatically recompile Typst documents (`.typ`) upon change and open the PDF output. It:

- Runs `typst watch` in the background  
- Automatically opens (and updates) the PDF file  
- Allows you to configure your preferred PDF viewer

---

## Installation

Make sure these are installed :

- [Typst](https://github.com/typst/typst) compiler 
- **PDF viewer**

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
return {
  "J0schu/typstwatch.nvim",
  ft = "typst",  -- Lazy load only for .typ files
  config = function()
    require("typstwatch").setup({
      viewer = "okular",  -- Optional: set your PDF viewer (defaults to "zathura")
    })
  end,
}
```
If **viewer** is not provided, the plugin falls back to `"zathura"`.

---

## Keymaps

```lua
vim.keymap.set("n", "<leader>ts", "<Plug>(typstwatch-start)", { desc = "Start Typst watch" })
vim.keymap.set("n", "<leader>tq", "<Plug>(typstwatch-stop)",  { desc = "Stop Typst watch" })
```

- **Start** → Launches `typst watch` for the current `.typ` buffer and opens the compiled PDF.  
- **Stop** → Stops the running watch job for the session.

### Commands

The plugin also exposes two user commands you can use without keymaps:

```vim
:TypstWatchStart
:TypstWatchStop
```