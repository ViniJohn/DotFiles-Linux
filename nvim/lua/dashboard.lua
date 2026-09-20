-- Introduction DASHBOARD
-- 1. Disable Neovim's default built-in startup intro text
vim.opt.shortmess:append("I")
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Ensure Neovim was launched completely empty
    if vim.fn.argc() == 0 and vim.api.nvim_buf_get_name(0) == "" and vim.bo.filetype == "" then
      local buf = vim.api.nvim_get_current_buf()
      -- 💾 BACKUP USER SETTINGS (Captured after init.lua has finished loading your preferences)
      local original_laststatus = vim.opt.laststatus:get()
      local original_showtabline = vim.opt.showtabline:get()
      local original_ruler = vim.opt.ruler:get()
      local original_number = vim.wo.number
      local original_relativenumber = vim.wo.relativenumber
      local original_signcolumn = vim.wo.signcolumn
      local original_cursorline = vim.wo.cursorline
      local original_fillchars = vim.wo.fillchars
      -- Clear out the [Scratch] buffer name tag completely
      vim.api.nvim_buf_set_name(buf, " ")
      -- Get total usable lines (height) and columns (width) of the UI window
      local win_height = vim.api.nvim_win_get_height(0)
      local win_width = vim.api.nvim_win_get_width(0)
      -- Clean, flat, spaced out format using your favorite Enclosed Alphanumerics
      local display_word = "🅽  🅴  🅾  🆅  🅸  🅼"
      -- Math: Use strdisplaywidth to handle visual centering across multi-byte symbols
      local word_visual_width = vim.fn.strdisplaywidth(display_word)
      local target_spaces = math.floor((win_width - word_visual_width) / 2)
      if target_spaces < 0 then target_spaces = 0 end
      local horizontal_padding = string.rep(" ", target_spaces)
      local centered_line = horizontal_padding .. display_word
      -- Math: Calculate vertical center line
      local vertical_padding_count = math.floor(win_height / 2) - 1
      if vertical_padding_count < 0 then vertical_padding_count = 0 end
      -- Construct the page layout dynamically
      local dashboard_lines = {}
      for _ = 1, vertical_padding_count do
        table.insert(dashboard_lines, "")
      end
      table.insert(dashboard_lines, centered_line)
      -- Draw the text onto the screen buffer
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, dashboard_lines)
      -- Enforce buffer visual rules natively
      vim.bo[buf].buftype = "nofile"
      vim.bo[buf].bufhidden = "wipe"
      vim.bo[buf].swapfile = false
      -- 🛑 HIDE CURRENT WINDOW ELEMENTS FOR DASHBOARD
      vim.wo.number = false
      vim.wo.relativenumber = false
      vim.wo.signcolumn = "no"
      vim.wo.cursorline = false
      vim.wo.fillchars = "eob: " -- Clear out tildes
      -- 🛑 COMPLETELY HIDE ALL VISUAL INTERFACE LINES & CORNER TEXTS
      vim.opt.laststatus = 0   -- Turn off the bottom status bar
      vim.opt.showtabline = 0  -- Turn off the top buffer bar
      vim.opt.ruler = false    -- REMOVE THE POSITION RULER TEXT FROM THE CORNER
      -- 🔄 THE AUTOMATIC RECOVERY LOOP
      -- The exact moment you open a file or start coding, restore everything back to normal.
      vim.api.nvim_create_autocmd("BufLeave", {
        buffer = buf,
        once = true,
        callback = function()
          -- Restore global UI lines
          vim.opt.laststatus = original_laststatus
          vim.opt.showtabline = original_showtabline
          vim.opt.ruler = original_ruler
          -- Restore window line numbers and formatting rules perfectly
          vim.wo.number = original_number
          vim.wo.relativenumber = original_relativenumber
          vim.wo.signcolumn = original_signcolumn
          vim.wo.cursorline = original_cursorline
          vim.wo.fillchars = original_fillchars
        end,
      })
    end
  end,
})
