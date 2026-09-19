
vim.g.mapleader = " "

--Insert Mode 
vim.keymap.set("i", "jj", "<Esc><cmd>w<CR>", {desc = " Save and  escape insert mode"})
vim.keymap.set("i", "jk", "<Esc>", {desc = "Escape insert mode"})

-- Normal mode
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search match and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search match and center" })

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlight" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

vim.keymap.set('n', '<CR>', '<cmd>call append(line("."), "")<CR>', { desc = "Insert line below" })

-- Visual mode 
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Cross-platform Clipboard Setup (Linux & WSL)
vim.opt.clipboard = "unnamedplus"

if vim.fn.has("wsl") == 1 then
  -- Faster internal Neovim register fallback function for pasting
  local function native_paste()
    return {
      vim.fn.split(vim.fn.getreg(""), "\n"),
      vim.fn.getregtype(""),
    }
  end

  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = native_paste,
      ["*"] = native_paste,
    },
  }
end

