-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

local g = vim.g
local opt = vim.opt
--
-- -------------------------------------- options ------------------------------------------
-- Leader key
g.mapleader = ","

-- -- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.autoindent = true
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4

-- Sync OS & Nvim clipboard
-- opt.clipboard = 'unnamedplus'

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- disable highlight search
vim.opt.hlsearch = false
opt.incsearch = true

vim.g.loading_session = false

-------------------------------------- autocmds ------------------------------------------
local autocmd = vim.api.nvim_create_autocmd

-- Strip trailing whitespace
autocmd("BufWritePre", {
  pattern = {"*"},
  callback = function(ev)
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
} )

-- Strip trailing whitespace
autocmd("CursorMoved", {
  pattern = {"*"},
  callback = function(ev)
    vim.cmd("set nohlsearch")
  end,
})

-- LOCAL FUNCTION
local bufilter = function()
  -- local bufs = vim.t.bufs or nil
  local bufs = vim.api.nvim_list_bufs() or nil

  if not bufs then
    return {}
  end

  for i, nr in ipairs(bufs) do
    if not vim.api.nvim_buf_is_valid(nr) then
      table.remove(bufs, i)
    end
  end

  vim.t.bufs = bufs
  return bufs
end

function check_buffers()
    -- for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    --     if vim.api.nvim_buf_get_option(buf, 'swapfile') then
    --       -- Buffer is still being loaded, return early
    --       return false
    --     end
    -- end
    local bufs = bufilter() or {}

    for _, buf in bufs do
        if vim.api.nvim_buf_get_option(buf, 'swapfile') then
          -- Buffer is still being loaded, return early
          return false
        end
    end

    -- Otherwise, finished loading
    -- vim.g.loading_session = false
    return true
end

-- Reorganize buffers
-- autocmd( { "BufNewFile", "BufEnter" }, {
autocmd( { "BufReadPre" }, {
  pattern = {"*"},
  callback = function()
    if vim.bo.filetype ~= "NerdTree*" and #vim.t.bufs > 1 then
      -- vim.g.loading_session = true
    else
      -- vim.g.loading_session = false
      print("One buffer")
    end

    -- vim.cmd("b#")
    -- local newBuf =  vim.api.nvim_get_current_buf()
    -- local newIndex = require("nvchad_ui.tabufline").getBufIndex(newBuf)
    --
    -- -- Adjust for wanting the next position
    -- local numPos = curIndex - newIndex + 1
    -- print("Previous = "..prevIndex..", New = "..newIndex..", Pos = "..numPos)
  --   local save_cursor = vim.fn.getpos(".")
  --   vim.cmd([[%s/\s\+$//e]])
  --   vim.fn.setpos(".", save_cursor)
  end,
})


autocmd( { "BufReadPost" }, {
  pattern = {"*"},
  callback = function()
    if vim.bo.filetype ~= "NerdTree*" and #vim.t.bufs > 1 then
      -- TODO: Fix this at some point
      -- if vim.g.loading_session == false then
      --   vim.cmd("b#")
      --   local prevBuf = vim.api.nvim_get_current_buf()
      --   local prevIndex = require("nvchad_ui.tabufline").getBufIndex(prevBuf)
      --   print("Previous = "..prevIndex)
      -- else
      --   print("Session active")
      -- end

    else
      print("One buffer")
    end

    -- vim.cmd("b#")
    -- local newBuf =  vim.api.nvim_get_current_buf()
    -- local newIndex = require("nvchad_ui.tabufline").getBufIndex(newBuf)
    --
    -- -- Adjust for wanting the next position
    -- local numPos = curIndex - newIndex + 1
    -- print("Previous = "..prevIndex..", New = "..newIndex..", Pos = "..numPos)
  --   local save_cursor = vim.fn.getpos(".")
  --   vim.cmd([[%s/\s\+$//e]])
  --   vim.fn.setpos(".", save_cursor)
  end,
})

-- TODO: Aiste -- you are here!
-- 1. Copy over the buffer reorder function as a local function
-- 2. Add BuffRead autocmd to reorder the buffers. Might need to have one that's a buffer create
-- Note: BufReadPre and BufReadPost!
-- BufReadPre - set global variable



-------------------------------------- commands ------------------------------------------
function sourceFile(file)
    vim.g.sourceFile = file

    if string.match(file, "sessions/") then
        vim.g.loading_session = true
    end

    vim.api.nvim_command("source" .. file)

    if string.match(file, "sessions/") then
        vim.g.loading_session = false
    end
end


local new_cmd = vim.api.nvim_create_user_command

-- NOTE: this isn't ideal -- this needs to be fixed to allow command line complete (CMP)
new_cmd("Session", function(opts)
    local usage = "Usage: :Session <filename>"
    if not opts.args or string.len(opts.args) < 1 then
        print(usage)
        return
    end
    sourceFile(opts.args)
end, {})
