local watcher = require('typstwatch.watcher')
local M = {}

function M.setup(user_config)
  watcher.setup(user_config or {})

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'typst',
    callback = function()
      -- Set up <Plug> mappings (no defaults)
      vim.keymap.set('n', '<Plug>(typstwatch-start)', watcher.start_watch, {
        buffer = true,
        silent = true,
      })
      vim.keymap.set('n', '<Plug>(typstwatch-stop)', watcher.stop_watch, {
        buffer = true,
        silent = true,
      })
    end,
  })
end
