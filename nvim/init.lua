



vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

-- ==== Plugins ====
require("lazy").setup({
  -- LSP for C/C++
  { "neovim/nvim-lspconfig" },

  -- Autocomplete engine
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },

  -- Comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  },
  -- VimCool (no highlight after search)
  {
    "romainl/vim-cool",
    event = "CmdlineEnter",  -- lazy-load when entering search or command-line mode
  },
  -- ColorSchemes 
  --Tokyo Night
  -- {
  --   "folke/tokyonight.nvim",
  --   config = function()
  --     vim.g.tokyonight_style = "moon"
  --     vim.g.tokyonight_transparent = false 
  --     vim.g.tokyonight_italic_comments = false 
  --     vim.g.tokyonight_italic_keywords = false
  --     
  --     vim.cmd("colorscheme tokyonight")
  -- end
  -- },
   
  -- Kanagawa colorscheme
  -- {
  --   "rebelot/kanagawa.nvim",
  --   config = function()
  --     require("kanagawa").setup({
  --       compile = true,
  --       undercurl = true,
  --       commentStyle = { italic = true },
  --       keywordStyle = { italic = true },
  --       statementStyle = { bold = true },
  --       transparent = false,
  --     })
  --     vim.cmd("colorscheme kanagawa")
  --   end
  -- },
 
  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      -- recommended: disable netrw early
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
  
      require("nvim-tree").setup({
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")
          local function opts(desc)
            return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
  
          vim.keymap.set('n', '<CR>', api.node.open.edit, opts("Open"))
          vim.keymap.set('n', 'o', api.node.open.edit, opts("Open"))
          vim.keymap.set('n', 'v', api.node.open.vertical, opts("Open: Vertical Split"))
          vim.keymap.set('n', 's', api.node.open.horizontal, opts("Open: Horizontal Split"))
          vim.keymap.set('n', 't', api.node.open.tab, opts("Open: New Tab"))
          vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts("Close Folder"))
          vim.keymap.set('n', 'l', api.node.open.edit, opts("Open"))
        end,
  
        sort = { sorter = "case_sensitive" },
        view = {
          width = 30,
          side = "left",
          adaptive_size = false,
        },
        renderer = { group_empty = true },
        filters = { dotfiles = false },
        git = { enable = true, ignore = false },
      })
  
      -- Global toggle keymaps
      vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>o', ':NvimTreeOpen<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>c', ':NvimTreeClose<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>r', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>f', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })
    end,
  }

})

-- ===== Editor Settings =====
vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false
vim.opt.cursorline = true

vim.o.timeoutlen = 200
vim.o.ttimeoutlen = 10

-- ===== Keymaps =====
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("c", "jk", "<C-c>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- ===== CMP (Autocomplete) =====
local cmp = require("cmp")
cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "nvim_lsp" },
  },
})

-- ===== LSP Setup (clangd — Neovim 0.11 API) =====
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp" },
  callback = function()
    vim.lsp.start({
      name = "clangd",
      cmd = { "clangd" },
      capabilities = capabilities,
    })
  end,
})


