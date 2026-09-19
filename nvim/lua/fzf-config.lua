vim.pack.add{ "https://github.com/ibhagwan/fzf-lua.git"}
--fzf-lua configuration

local has_fzf, fzf = pcall(require, "fzf-lua")
if not has_fzf then
    print("fzf-lua is not installed!")
    return
end

fzf.setup({ui_select = {true}})

-- --fzf keymaps
local keymap = vim.keymap.set
keymap("n", "<leader>ff", fzf.files, { desc = "Fzf Files" })
keymap("n", "<leader>fb", fzf.buffers, { desc = "Fzf buffers" })
keymap("n", "<leader>fs", fzf.blines, { desc = "Fzf live_grep" })
-- Search symbols in the current buffer using LSP
keymap("n", "<leader>fo", require("fzf-lua").lsp_document_symbols, { desc = "Fzf LSP Document Symbols" })

