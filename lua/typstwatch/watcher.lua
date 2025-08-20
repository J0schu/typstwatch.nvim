local M = {}
local job_id = nil
local _config = {}

local function pdf_path()
  local path = vim.api.nvim_buf_get_name(0)
  return path:gsub('%.typ$', '.pdf')
end

function M.start_watch()
  if job_id then
    vim.notify('Typst watch already running.', vim.log.levels.INFO)
    return
  end
  local input = vim.api.nvim_buf_get_name(0)
  if not input:match('%.typ$') then
    vim.notify('Not a .typ file.', vim.log.levels.WARN)
    return
  end

  local pdf = pdf_path()
  job_id = vim.fn.jobstart({ 'sh', '-c', ('typst watch %q'):format(input) }, {
    on_exit = function()
      job_id = nil
      vim.notify('Typst watch stopped.', vim.log.levels.INFO)
    end,
    detach = true,
  })

  local viewer = _config.viewer or 'zathura'
  vim.fn.jobstart({ 'sh', '-c', (('%s %q &'):format(viewer, pdf)) }, { detach = true })

  vim.notify('Typst watch started with viewer: ' .. viewer, vim.log.levels.INFO)
end

function M.stop_watch()
  if not job_id then
    vim.notify('Typst watch is not running.', vim.log.levels.INFO)
    return
  end
  vim.fn.jobstop(job_id)
  job_id = nil
  vim.notify('Typst watch stopped.', vim.log.levels.INFO)
end

function M.setup(config)
  _config = config or {}
end

return M