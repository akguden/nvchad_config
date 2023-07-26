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
        ["<leader>vq"] = { "<cmd>confirm q<CR>", "Quit", opts = { nowait = true } },

        -- close buffer + hide terminal buffer
        ["<leader>bq"] = {
            function()
                require("nvchad_ui.tabufline").close_buffer()
            end,
            "Close buffer",
        },

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
        -- NOTE: recommend printing out the buffer indexes of prev. and new buffer for debug!
        vim.cmd "enew"
       --
       --  local curbuf = vim.api.nvim_get_current_buf()
       --  local bufIndex = require("nvchad_ui.tabufline").getBufIndex(curbuf)
       -- 
       --  local bufs = vim.t.bufs
       --  local newIdx = bufs[#bufs]
       --  local moveNums = bufIndex - newIdx
       --
       --  -- TODO: Aiste -- you'll need to override this function to accept new buffer index
       --  require("nvchad_ui.tabufline").move_buf(-1)
      end,
      "Goto prev buffer",
    },

    ["bb"] = {
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
