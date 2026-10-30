-- Open terminal

-- command to run a CLI agent
local AGENT = "cursor-agent"

local terminal_buf = nil
local agent_buf = nil

local function toggle_terminal(buf, split, autocommand)
  split = split or "h"
  local split_cmd = split == "v" and "botright 100vsplit" or "bot 12split"

  if buf and vim.api.nvim_buf_is_valid(buf) then
    local wins = vim.fn.win_findbuf(buf)

    -- hide terminal if its window is visible
    if #wins > 0 then
      vim.api.nvim_win_hide(wins[1])
      return buf
    end

    -- reopen existing terminal
    vim.cmd(split_cmd)
    vim.api.nvim_win_set_buf(0, buf)
  else
    -- create new terminal
    vim.cmd(split_cmd)
    vim.cmd("terminal")

    if autocommand then
      vim.cmd("startinsert")
      local job_id = vim.b.terminal_job_id
      if job_id then
        vim.fn.chansend(job_id, autocommand .. "\r")
      end
    end
  end

  return vim.api.nvim_get_current_buf()
end

vim.keymap.set("n", "<leader>t", function()
  terminal_buf = toggle_terminal(terminal_buf)
end)

vim.keymap.set("n", "<leader>a", function()
  agent_buf = toggle_terminal(agent_buf, "v", AGENT)
end)


-- Send reference to current file (and line / selected lines) to the agent terminal
vim.keymap.set({ "n", "x" }, "<A-l>", function()
  vim.notify("Linking file", vim.log.levels.WARN)
  if not (agent_buf and vim.api.nvim_buf_is_valid(agent_buf)) then
    vim.notify("Agent terminal is not open", vim.log.levels.WARN)
    return
  end

  local job_id = vim.b[agent_buf].terminal_job_id
  if not job_id then
    vim.notify("Agent terminal has no running job", vim.log.levels.WARN)
    return
  end

  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    vim.notify("Current buffer has no file", vim.log.levels.WARN)
    return
  end

  local mode = vim.fn.mode()
  local first, last = vim.fn.line("."), vim.fn.line(".")
  if mode == "v" or mode == "V" or mode == "\22" then
    first, last = vim.fn.line("v"), vim.fn.line(".")
    if first > last then
      first, last = last, first
    end
    vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
  end

  local ref = "@" .. vim.fn.fnamemodify(name, ":.") .. ":" .. first
  if last ~= first then
    ref = ref .. "-" .. last
  end

  vim.fn.chansend(job_id, ref .. " ")

  -- focus the agent terminal window
  local wins = vim.fn.win_findbuf(agent_buf)
  if #wins > 0 then
    vim.api.nvim_set_current_win(wins[1])
    vim.cmd("startinsert")
  end
end)
