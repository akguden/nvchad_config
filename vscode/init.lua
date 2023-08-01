-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

if vim.g.vscode then
    local g = vim.g
    local opt = vim.opt
    --
    -- -------------------------------------- options ------------------------------------------
    -- -- Indenting
    opt.expandtab = true
    opt.shiftwidth = 4
    opt.smartindent = true
    opt.tabstop = 4
    opt.softtabstop = 4

    -- Sync OS & Nvim clipboard
    -- opt.clipboard = 'unnamedplus'

    -- Case-insensitive searching UNLESS \C or capital in search
    opt.ignorecase = true
    opt.smartcase = true

    -- Leader key
    g.mapleader = ","
else
    -- Non-VScode..?
end

