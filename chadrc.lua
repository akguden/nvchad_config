---@type ChadrcConfig
local M = {}

  -- Path to overriding theme and highlights files
  local highlights = require "custom.highlights"

  M.ui = {
    theme = "catppuccin",
    theme_toggle = { "catppuccin", "one_light" },
    lsp_semantic_tokens = true, -- needs nvim v0.9, just adds highlight groups for lsp semantic tokens
  
    hl_override = highlights.override,
    hl_add = highlights.add,
    nvdash = {
      load_on_startup = true,
      buttons = {
        { "  Find File", "<leader> f f", "Telescope find_files" },
        { "󰈚  Recent Files", "<leader> f o", "Telescope oldfiles" },
        { "󰈭  Find Word", "<leader> f w", "Telescope live_grep" },
        { "  Bookmarks", "<leader> m a", "Telescope marks" },
        { "  Themes", "<leader> t h", "Telescope themes" },
        { "  Mappings", "<leader> c h", "NvCheatsheet" },
      },
    },
  }

  M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
