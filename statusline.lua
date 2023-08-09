local M = {}

local statusline = require "nvchad_ui.statusline.default"

M.cursor_position = function ()
    return statusline.LSP_status()
end

M.LSP_status = function()
    -- return statusline.cursor_position()
    local txt = statusline.cursor_position() -- "[] l%"
    local col = ", Col %c"
    local trail_i = txt:find "%s+$"
    return (trail_i and txt:sub(1, trail_i - 1) .. col .. txt:sub(trail_i)) or txt .. col
end

return M
