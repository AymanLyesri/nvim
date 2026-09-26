-- Floating terminal. See :help nvim_open_win, :help terminal.
local M = {}
M.state = { buf = -1, win = -1 }

function M.open()
  local width, height = vim.o.columns, vim.o.lines
  local uis = vim.api.nvim_list_uis()
  if #uis > 0 then
    width, height = uis[1].width, uis[1].height
  end
  local w, h = math.floor(width * 0.8), math.floor(height * 0.8)
  local row, col = math.floor((height - h) / 2), math.floor((width - w) / 2)
  if not vim.api.nvim_buf_is_valid(M.state.buf) then
    M.state.buf = vim.api.nvim_create_buf(false, true)
  end
  M.state.win = vim.api.nvim_open_win(M.state.buf, true, {
    relative = "editor",
    width = w,
    height = h,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })
  if vim.bo[M.state.buf].buftype ~= "terminal" then
    vim.cmd.term()
  end
  vim.cmd.startinsert()
  vim.keymap.set("n", "<Esc>", M.hide, { buffer = M.state.buf, desc = "Hide floating terminal" })
end

function M.hide()
  if vim.api.nvim_win_is_valid(M.state.win) then
    vim.api.nvim_win_hide(M.state.win)
  end
end

function M.toggle()
  if vim.api.nvim_win_is_valid(M.state.win) then
    M.hide()
  else
    M.open()
  end
end

vim.api.nvim_create_user_command("ToggleTerminal", M.toggle, {})
vim.keymap.set("n", "<leader>tt", M.toggle, { desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

return M
