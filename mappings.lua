---@type MappingsTable
local M = {}

M.general = {
    -- i = {
    --     ["<C-`>"] = { "`", "Insert backtick", opts = { nowait = true } },
    --     ["`"] = { "<ESC>", "Escape insert mode", opts = { nowait = true } },
    -- },
    n = {
        [";"] = { ":", "enter command mode", opts = { nowait = true } },

        -- exit VIM
        ["<leader>vq"] = { "<cmd>confirm qa<CR>", "Quit"},

        -- close buffer + hide terminal buffer
        ["<leader>bq"] = {
            function()
                require("nvchad_ui.tabufline").close_buffer()
            end,
            "Close buffer",
        },

        -- close window
        ["<leader>wq"] = { "<cmd>close<CR>", "Close current window"},

        ["<leader>w"] = { "<cmd>w<CR>", "Save" },

        -- Toggle NeovimTree
        ["<leader>ff"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

        -- Open new file, remap ff to switch to an open buffer
        ["<leader>e"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
        ["<leader>nf"] = { "<cmd> Telescope find_files <CR>", "Find files" },
        ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },

        ["<leader>fe"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },

        ["<D-r>"] = { "<cmd> redo <CR>", "Redo" },

        -- Stop annoying LSP stuff
        ["<leader>ls"] = { "<cmd>LspStop<CR>", "Stop LSP" },
        ["<Space>"] = { ":noh <CR>", "Clear highlights" },

        -- TODO: Aiste -- you are here! figure out how to insert buffer in the middle
    },
    v = {
        ["`"] = { "<ESC>", "Escape visual mode", opts = { nowait = true } },
    },
    x = {
        -- Note: this does not work! need conditional if there  are no tabs left
        -- ["q"] = {
        --     function()
        --         require("nvchad_ui.tabufline").close_buffer()
        --     end,
        --     "Close buffer",
        -- },
        ["q"] = { "<cmd>confirm q<CR>", "Quit", opts = { nowait = true } },
        ["Q"] = { "<cmd>confirm q<CR>", "Quit", opts = { nowait = true } },
    },
}

M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["<C-E>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["<C-A>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },

    -- close buffer + hide terminal buffer
    ["<leader>q"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
      end,
      "Close buffer",
    },

    ["<leader>bi"] = {
      function()
        local curbuf = vim.api.nvim_get_current_buf()
        local curIndex = require("nvchad_ui.tabufline").getBufIndex(curbuf)
        vim.cmd "b#"
        local prevbuf =  vim.api.nvim_get_current_buf()
        local prevIndex = require("nvchad_ui.tabufline").getBufIndex(prevbuf)
        vim.cmd "b#"

        -- Adjust for wanting the next position
        local numPos = prevIndex - curIndex + 1
        print("Previous = "..prevIndex..", New = "..curIndex..", Pos = "..numPos)
        require("nvchad_ui.tabufline").move_buf(numPos)
      end,
      "Re-order current buffer next to previously opened buffer",
    },

    ["bp"] = {
      function()
        require("nvchad_ui.tabufline").move_buf(-1)
      end,
      "Goto prev buffer",
    },

    ["bn"] = {
      function()
        require("nvchad_ui.tabufline").move_buf(1)
      end,
      "Goto prev buffer",
    },

  },
}

return M
