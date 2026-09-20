-- Essential structural choices
vim.opt.laststatus = 3
vim.opt.cmdheight = 0
vim.opt.showmode = false
vim.opt.termguicolors = true -- Required for custom Hex color groups below

-- 1. Define custom highlight colors for each mode block
-- Feel free to adjust the 'bg' (background) and 'fg' (foreground) hex values
vim.api.nvim_set_hl(0, 'StatusNormal', { bg = '#50fa7b', fg = '#282a36', bold = true }) -- Green
vim.api.nvim_set_hl(0, 'StatusInsert', { bg = '#ff79c6', fg = '#282a36', bold = true }) -- Pink
vim.api.nvim_set_hl(0, 'StatusVisual', { bg = '#bd93f9', fg = '#282a36', bold = true }) -- Purple
vim.api.nvim_set_hl(0, 'StatusReplace', { bg = '#ff5555', fg = '#282a36', bold = true }) -- Red
vim.api.nvim_set_hl(0, 'StatusCmd',     { bg = '#8be9fd', fg = '#282a36', bold = true }) -- Cyan
vim.api.nvim_set_hl(0, 'StatusDefault', { bg = '#44475a', fg = '#f8f8f2' })             -- Dark grey background for rest of bar

function FullMinimalStatusline()
  -- 2. Map raw Neovim modes to a single capitalized letter and highlight group
  local mode_map = {
    ['n']  = { 'N', 'StatusNormal' },
    ['v']  = { 'V', 'StatusVisual' },
    ['V']  = { 'V', 'StatusVisual' },
    ['\22'] = { 'V', 'StatusVisual' }, -- Visual Block
    ['i']  = { 'I', 'StatusInsert' },
    ['R']  = { 'R', 'StatusReplace' },
    ['c']  = { 'C', 'StatusCmd' },
  }

  local current_mode = vim.api.nvim_get_mode().mode
  local mode_info = mode_map[current_mode] or { 'N', 'StatusNormal' } -- Fallback
  local mode_char = mode_info[1]
  local mode_hl   = mode_info[2]

  -- 3. Construct the mode block with its background color
  -- %#GroupName# applies the highlight. %* resets it back to normal.
  local mode_display = string.format("%%#%s# %s %%*%%#StatusDefault#", mode_hl, mode_char)

  -- 4. Macro Indicator
  local recording = vim.fn.reg_recording()
  local macro = recording ~= "" and string.format("    Recording @%s ", recording) or ""

  -- 5. File Metadata
  local file = " %f %m %r"

  -- 6. Git Context (Requires gitsigns plugin, fails gracefully if missing)
  local git_branch = ""
  if vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.head ~= "" then
    git_branch = string.format("  %s", vim.b.gitsigns_status_dict.head)
  end

  -- 7. LSP Diagnostics
  local lsp_info = ""
  if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    if errors > 0 or warnings > 0 then
      lsp_info = string.format("  %d  %d ", errors, warnings)
    end
  end

  -- 8. Formatting Layout
  local align = "%="
  local location = "%l:%c "

  return table.concat({
    mode_display, macro, file, git_branch, align, lsp_info, location
  })
end

-- Apply the statusline globally
vim.opt.statusline = "%!v:lua.FullMinimalStatusline()"
