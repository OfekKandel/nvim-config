-- Basic Neovim options
local opt = vim.opt

-- Leader
vim.g.mapleader = " "

-- Custom keymaps
vim.keymap.set("n", "<C-x>", "<cmd>bd<CR>", { desc = "Close current buffer" })
-- Insert empty line without entering insert mode
vim.keymap.set('n', '<leader>o', ':<C-u>call append(line("."), repeat([""], v:count1))<CR>',
    { desc = "Insert empty line below" })
vim.keymap.set('n', '<leader>O', ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>',
    { desc = "Insert empty line above" })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Transparent background
vim.cmd("highlight Normal guibg=none")

-- Load cursor fix
vim.cmd('au VimEnter,VimResume * set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50\
  \\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor\
  \\,sm:block-blinkwait175-blinkoff150-blinkon175')

vim.cmd('au VimLeave,VimSuspend * set guicursor=a:ver1-blinkon0')

-- Nice Autocommands
vim.api.nvim_create_augroup('bufcheck', { clear = true })

-- reload config file on change
vim.api.nvim_create_autocmd('BufWritePost', {
    group   = 'bufcheck',
    pattern = vim.env.MYVIMRC,
    command = 'silent source %'
}
)

-- highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', {
    group    = 'bufcheck',
    pattern  = '*',
    callback = function() vim.highlight.on_yank { timeout = 200 } end
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH


-- Indentation
opt.expandtab = true   -- Use spaces instead of tabs
opt.tabstop = 4        -- Number of spaces tabs count for
opt.smartindent = true -- Insert indents automatically
opt.shiftwidth = 4     -- Size of an indent
opt.shiftround = true  -- Round indent (for >> and such)

-- Spelling
opt.spelllang = "en_us"
opt.spell = true

-- Misc
opt.cursorline = true             -- Enable highlighting of the current line
opt.colorcolumn = "100"           -- Enable a color column at 100 chars
opt.signcolumn = "yes"            -- Always show the signcolumn, otherwise it would shift the text each time
opt.ignorecase = true             -- Ignore case
opt.smartcase = true              -- Don't ignore case with capitals
opt.mouse = "a"                   -- Enable mouse mode
opt.relativenumber = true         -- Relative line numbers
opt.number = true                 -- Set line numbers
opt.scrolloff = 4                 -- Lines of context
opt.splitbelow = true             -- Put new windows below current
opt.splitright = true             -- Put new windows right of current
opt.termguicolors = true          -- True color support
vim.opt.swapfile = false          -- Disable swap files
opt.wrap = false                  -- Disable line wrap
vim.opt.fillchars = { eob = " " } -- Remove those tildes at the end of the file
