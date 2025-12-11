-- Editor options and settings
local opt = vim.opt
local g = vim.g

-- Appearance
opt.termguicolors = true
opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.cursorcolumn = true
opt.signcolumn = "yes"
opt.colorcolumn = "80,120"

-- Remove margins for VS Code-like look
opt.numberwidth = 1  -- Minimal width for line numbers
opt.fillchars = { eob = " " }  -- Hide ~ on empty lines
opt.cmdheight = 0  -- Hide command line when not in use
opt.laststatus = 3  -- Global statusline (no gap at bottom)
opt.showtabline = 2  -- Always show tabline

-- Indentation
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Behavior
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.swapfile = false
opt.backup = false

-- VSCode-like selection behavior
opt.selection = "exclusive"  -- Selection doesn't include char under cursor (like VSCode)
opt.virtualedit = "onemore"  -- Allow cursor one char past end of line

-- Performance
opt.timeoutlen = 300
opt.updatetime = 500  -- Faster CursorHold for hover docs (ms)

-- LSP hover/floating window appearance
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
  max_width = 80,
  max_height = 20,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
  max_width = 80,
})

-- Diagnostic floating window appearance
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 4,
  },
  float = {
    border = "rounded",
    source = true,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Split behavior
opt.splitbelow = true
opt.splitright = true

-- Text wrapping
opt.wrap = true
opt.linebreak = true

-- Disable netrw in favor of nvim-tree
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Enable enhanced keyboard protocol (CSI u) for better key handling
-- This allows Neovim to receive and distinguish modified keys like Cmd+C, Cmd+T, etc.
vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
  group = vim.api.nvim_create_augroup("KittyKeyboardProtocol", { clear = true }),
  callback = function()
    io.stdout:write("\x1b[>1u")  -- Enable CSI u protocol
  end,
})

vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
  group = vim.api.nvim_create_augroup("KittyKeyboardProtocolLeave", { clear = true }),
  callback = function()
    io.stdout:write("\x1b[<1u")  -- Disable CSI u protocol on exit
  end,
})
