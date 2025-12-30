



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
    event = "CmdlineEnter",  
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false, 
  },

  -- ColorSchemes 
-- {
--   "sainnhe/everforest",
--   lazy = false,
--   priority = 1000, -- make sure it loads first
--   config = function()
--     -- Style options (keep it clean)
--     vim.g.everforest_background = "hard"   -- hard | medium | soft
--     vim.g.everforest_enable_italic = 0
--     vim.g.everforest_disable_italic_comment = 1
--     vim.g.everforest_transparent_background = 1
--
--     vim.cmd("colorscheme everforest")
--   end,
-- },
{
  "arcticicestudio/nord-vim",
  lazy = false,
  priority = 1000,  -- load before other plugins
  config = function()
    vim.g.nord_contrast = "hard"          -- hard | soft | none
    vim.g.nord_borders = true             -- adds border to splits
    vim.g.nord_disable_background = false -- false = use dark background
    vim.g.nord_italic = false             -- disable italics
    vim.g.nord_bold = false               -- disable bold

    vim.cmd("colorscheme nord")
  end,
},






  --Tokyo Night
  -- {
  --   "folke/tokyonight.nvim",
  --   config = function()
  --     vim.g.tokyonight_transparent = true 
  --     vim.g.tokyonight_italic_comments = false 
  --     vim.g.tokyonight_italic_keywords = false
  --     
  --     vim.cmd("colorscheme tokyonight-night")
  -- end
  -- },
-- {
--   "rebelot/kanagawa.nvim",
--   config = function()
--     -- Optional: configure Kanagawa
--     require("kanagawa").setup({
--       compile = true,        -- enable compiling for faster startup
--       undercurl = true,
--       commentStyle = { italic = false },
--       functionStyle = {},
--       keywordStyle = { italic = false },
--       statementStyle = { bold = true },
--       typeStyle = {},
--       variablebuiltinStyle = { italic = true },
--       specialReturn = true,
--       specialException = true,
--       transparent = true,   -- false = normal background
--       dimInactive = false,
--     })
--     -- Set colorscheme
--     vim.cmd("colorscheme kanagawa") -- you can also try kanagawa-dragon or kanagawa-lotus
--   end
-- },
-- {
--   "aktersnurra/no-clown-fiesta.nvim",
--   config = function()
--     -- optional: set variant
--     vim.g.ncf_variant = "dark" -- or "dark", default is "dark"
--
--     -- apply colorscheme
--     vim.cmd("colorscheme no-clown-fiesta")
--   end,
-- },
  -- FileExplorer 
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
vim.opt.termguicolors = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false
vim.opt.cursorline = true

vim.o.timeoutlen = 200
vim.o.ttimeoutlen = 10

-- Black Background
vim.cmd("hi Normal guibg=#0F1419 ctermbg=0")
vim.cmd("hi NormalNC guibg=#0F1419 ctermbg=0")
vim.cmd("hi NormalFloat guibg=#0F1419 ctermbg=0")
vim.cmd("hi VertSplit guibg=#0F1419 ctermbg=0")
vim.cmd("hi StatusLine guibg=#0F1419 ctermbg=0")
vim.cmd("hi SignColumn guibg=#0F1419 ctermbg=0")

-- ===== Keymaps =====
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("c", "jk", "<C-c>")

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


