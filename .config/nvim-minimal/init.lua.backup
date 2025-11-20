-- -----------------------------------------------------------------------------
-- >> LEADER KEY & GLOBALS
-- Let's get this out of the way first. It's foundational.
-- -----------------------------------------------------------------------------
vim.g.mapleader = " "

-- -----------------------------------------------------------------------------
-- >> CORE OPTIONS
-- The meat and potatoes of your config. All the `vim.opt` stuff is here,
-- but broken down into categories so it's not a giant wall of text.
-- -----------------------------------------------------------------------------

-- General Editor Behavior
vim.opt.compatible = false               -- Ditch vi compatibility. It's 2025.
vim.opt.mouse = "a"                      -- Enable the mouse. Yes, in a terminal editor.
vim.opt.clipboard = "unnamedplus"        -- Use the system clipboard. A must-have.
vim.opt.backspace = { "indent", "eol", "start" } -- Make backspace behave sanely.
vim.opt.encoding = "utf-8"               -- Set default encoding.
vim.opt.updatetime = 300                 -- Faster updates for plugins, git signs, etc.

-- Files and Buffers
vim.opt.swapfile = false                 -- No swap files cluttering your directories.
vim.opt.backup = false                   -- No backup files, either.
vim.opt.undofile = true                  -- Persistent undo. This one's a life-saver.
vim.cmd("filetype plugin indent on")     -- Enable filetype-specific settings.

-- Indentation
vim.opt.tabstop = 4                      -- Tabs are 4 spaces wide.
vim.opt.shiftwidth = 4                   -- Indent by 4 spaces.
vim.opt.expandtab = true                 -- Use spaces, not tabs. Fight me.
vim.opt.smartindent = true               -- Be smart about indentation.

-- Search
vim.opt.hlsearch = true                  -- Highlight all search results.
vim.opt.incsearch = true                 -- Show matches as you type.
vim.opt.ignorecase = true                -- Case-insensitive searching...
vim.opt.smartcase = true                 -- ...unless you use a capital letter.

-- UI & Visuals
vim.cmd("syntax on")                     -- Obvious, but necessary.
vim.opt.termguicolors = true             -- Enable 24-bit RGB color. It's pretty.
vim.opt.number = true                    -- Show line numbers.
vim.opt.relativenumber = true            -- Show relative line numbers. Good for jumping.
vim.opt.cursorline = true                -- Highlight the current line.
vim.opt.wrap = false                     -- Don't wrap lines by default.
vim.opt.numberwidth = 2                  -- At least 2 columns for the line number gutter.
vim.opt.signcolumn = "auto"              -- Only show the sign column when needed.
vim.opt.scrolloff = 7                    -- Keep 7 lines visible above/below the cursor.
vim.opt.ruler = true                     -- Show cursor position.
vim.opt.showcmd = true                   -- Show incomplete commands.
vim.opt.showmode = true                  -- Show the current mode.
vim.opt.laststatus = 2                   -- Always show the status line.

-- Cursor Shape (for modern terminals)
vim.opt.guicursor = {
  "n-v-c:block",
  "i-ci:ver25-blinkwait700-blinkon400-blinkoff250",
  "r-cr:hor20-blinkwait700-blinkon400-blinkoff250",
  "o:hor50",
}

-- -----------------------------------------------------------------------------
-- >> KEYMAPS
-- The fun part. All your custom shortcuts in one place.
-- Giving them a `desc` is good practice for plugins like which-key.
-- -----------------------------------------------------------------------------

-- Utility & Session
vim.keymap.set("n", "<leader>qq", ":qa<CR>", { desc = "Quit All" })
vim.keymap.set({ "i", "n" }, "<C-S>", "<Esc>:w<CR>", { noremap = true, desc = "Save File" })
vim.keymap.set("c", "w!!", "w !sudo tee > /dev/null %", { noremap = true, desc = "Sudo Save" })

-- Editing
vim.keymap.set("n", "<leader>uw", function() vim.cmd("set wrap!") end, { desc = "Toggle line wrap" })
vim.keymap.set({ 'i', 'c' }, '<C-BS>', '<C-w>', { desc = 'Delete word backward' })
vim.keymap.set("n", "<Esc>", vim.cmd.nohlsearch, { desc = "Clear search highlight" })

-- Window & Split Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- map leader key to jump to file dir
vim.keymap.set('n', '<leader>cd', ':cd %:p:h<CR>', { desc = 'CD to current file' })

-- Buffer & Tab Management
local function is_zoomed()
  return vim.fn.tabpagenr('$') > 1 and vim.fn.winnr('$') == 1
end

vim.keymap.set("n", "<leader>uz", function()
  if is_zoomed() then
    vim.cmd("tabclose")
  else
    vim.cmd("tab split")
  end
end, { desc = "Toggle Zoom" })

vim.keymap.set("n", "<leader>wd", function()
  if is_zoomed() then
    vim.cmd("tabclose")
  else
    vim.cmd("close")
  end
end, { desc = "Close Window" })

vim.keymap.set("n", "<leader>bd", function() require("snacks").bufdelete() end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bb", "<C-^>", { desc = "Switch to Alternate Buffer" })
vim.keymap.set("n", "<leader>bo", function()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and buf ~= current_buf then
      -- Assuming 'snacks' is some plugin you have.
      -- This loop is a bit brute-force, but it works.
      require("snacks").bufdelete(buf)
    end
  end
end, { desc = "Delete Other Buffers" })


-- -----------------------------------------------------------------------------
-- >> AUTOCOMMANDS
-- Things that happen automatically. Magic, basically.
-- -----------------------------------------------------------------------------
local augroup = vim.api.nvim_create_augroup("MyCustomAutocmds", { clear = true })

-- Highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  desc = "Highlight on yank",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Auto-normalize window splits after terminal resize
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  desc = "Resize splits on terminal resize",
  callback = function() vim.cmd("wincmd =") end,
})


-- -----------------------------------------------------------------------------
-- >> AESTHETICS
-- Final touches to make it look pretty. Or, in this case, transparent.
-- -----------------------------------------------------------------------------
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" }) -- Make the background transparent


-- Plugin manager
-- -----------------------------------------------------------------------------
-- >> LAZY.NVIM BOOTSTRAP
-- Standard stuff. If lazy.nvim isn't there, install it. Don't touch this.
-- -----------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- -----------------------------------------------------------------------------
-- >> PLUGIN DEFINITIONS
-- Here's the main event.
-- -----------------------------------------------------------------------------
require("lazy").setup({

  -- >> THEME
  -- Load this first, or you'll get a screen flash.
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        transparent_background_level = 1,
        ui_contrast = "high",
      })
      vim.cmd.colorscheme("everforest")

      -- Brighter line numbers to stand out against the theme
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#d0d0d0" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffffff", bold = true })
    end,
  },

  -- >> CORE UI & UX
  -- File explorers, fuzzy finders, dashboards, etc.
  {
    "echasnovski/mini.files",
    version = false,
    config = function()
      require("mini.files").setup({
        mappings = {
          go_in = 'l', go_in_plus = '<CR>',
          go_out = 'h', go_out_plus = 'H',
          reset = '<BS>',
        },
        options = { use_as_default_explorer = false },
      })
      vim.keymap.set("n", "<leader>e", function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end, { desc = "Explorer (mini.files)" })
    end,
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      picker = { enabled = true, sorting = "fzy", prompt = "❯ ", matcher = { frecency = true }, max_results = 2000 },
      bufdelete = { enabled = true },
      quickfile = { enabled = true },
      lazygit = { enabled = true },
      dashboard = { enabled = true },
      statuscolumn = { enabled = true },
    },
    config = function(_, opts)
      require("snacks").setup(opts)
      -- Keymaps for snacks features
      vim.keymap.set("n", "<leader>ff", function() require("snacks").picker.files({}) end, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>sg", function() require("snacks").picker.grep({ live = true }) end, { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>fb", function() require("snacks").picker.buffers({}) end, { desc = "Find Buffers" })
      vim.keymap.set("n", "<leader>fr", function() require("snacks").picker.recent({}) end, { desc = "Recent Files" })
      vim.keymap.set("n", "<leader>gg", function() require("snacks").lazygit() end, { desc = "Open LazyGit" })
    end,
  },

  -- >> UTILITIES & EDITING AIDS
  -- Small plugins that make life better.
  { "tpope/vim-surround", event = "VeryLazy" },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true, -- `true` calls `require("plugin").setup()`
  },

  -- >> LSP & COMPLETION
  -- The brains of the operation. This section is always a bit of a monster.
  { "folke/neodev.nvim", opts = {} },
  { "williamboman/mason.nvim", build = ":MasonUpdate", config = true },
  { "neovim/nvim-lspconfig" },
{
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
  config = function()
    local mlsp = require("mason-lspconfig")
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- V V V V V V V V V V V V V V V V V V V V V V V V
    -- HERE IS THE GUARD: A table to track setup servers
    local servers_setup = {}
    -- ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^

    local function on_attach(_, bufnr)
      local o = { buffer = bufnr, silent = true }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, o)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, o)
      vim.keymap.set("n", "gr", function() require("snacks").picker.lsp_references() end, o)
    end

    local function setup_server(server_name)
      -- V V V V V V V V V V V V V V V V V V V V V V V V
      -- THE GUARD CLAUSE IN ACTION:
      -- If we've already set this server up, do nothing.
      if servers_setup[server_name] then return end
      -- ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^

      local server_opts = {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      if server_name == "lua_ls" then
        server_opts.settings = {
          Lua = { diagnostics = { globals = { "vim" } }, workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } } },
        }
      elseif server_name == "intelephense" then
        server_opts.settings = { intelephense = { files = { maxSize = 5000000 } } }
      end

      lspconfig[server_name].setup(server_opts)

      -- V V V V V V V V V V V V V V V V V V V V V V V V
      -- After a successful setup, add the server to our list.
      servers_setup[server_name] = true
      -- ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^
    end

    -- The rest of the logic remains the same.
    if type(mlsp.setup_handlers) == "function" then
      mlsp.setup_handlers({
        function(server_name) setup_server(server_name) end,
      })
    else
      for _, server_name in ipairs(mlsp.get_installed_servers()) do
        setup_server(server_name)
      end
    end
  end,
},
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        completion = { completeopt = "menu,menuone,noselect" },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "path" }, { name = "buffer" } }),
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })
    end,
  },

  -- >> TREESITTER
  -- For syntax-aware highlighting, text objects, and more.
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "php", "javascript", "html", "css", "json", "bash", "markdown", "markdown_inline", "vim" },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = { init_selection = "gnn", node_incremental = "grn", scope_incremental = "grc", node_decremental = "grm" },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = { ["af"] = "@function.outer", ["if"] = "@function.inner", ["ac"] = "@class.outer", ["ic"] = "@class.inner" },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
            goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
          },
        },
      })

      -- Treesitter Context (sticky header)
      require("treesitter-context").setup({ max_lines = 2, separator = " " })
      vim.api.nvim_set_hl(0, "TreesitterContext", { link = "Normal" }) -- Use normal background
      vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { link = "LineNr" })

      -- Auto-tag
      require("nvim-ts-autotag").setup()

      -- Folding
      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "nvim_treesitter#foldexpr()"
      vim.o.foldenable = false -- Disabled by default, personal preference
    end,
  },
})

-- -----------------------------------------------------------------------------
-- >> EXTERNAL INTEGRATIONS & CUSTOM FUNCTIONS
-- Logic that doesn't belong to a single plugin.
-- Keeping it separate from the lazy setup makes it easier to find.
-- -----------------------------------------------------------------------------

-- Keymap for Yazi file manager in a float
vim.keymap.set("n", "<leader>-", function()
  local parent_win = vim.api.nvim_get_current_win()
  local tmpfile = vim.fn.tempname()
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    width = width, height = height,
    style = "minimal", border = "rounded",
  })
  vim.fn.termopen({ "yazi", "--chooser-file", tmpfile }, {
    on_exit = function()
      pcall(vim.api.nvim_win_close, win, true)
      if vim.api.nvim_win_is_valid(parent_win) then pcall(vim.api.nvim_set_current_win, parent_win) end
      vim.schedule(function()
        if vim.loop.fs_stat(tmpfile) then
          local sel = vim.fn.readfile(tmpfile)[1] or ""
          if #sel > 0 then vim.cmd.edit(vim.fn.fnameescape(sel)) end
          pcall(vim.loop.fs_unlink, tmpfile)
        end
      end)
    end,
  })
  vim.cmd.startinsert()
end, { desc = "File Manager (Yazi)" })

-- Custom command and keymap for your 'tips' script
local tips_cmd = [[cd ~/Documents/notes/vim && find . -maxdepth 1 -type f -printf '%f\n' | rofi -dmenu -p 'tips' | xargs -r -I{} zsh -ic 'source ~/.config/oh-my-zsh/custom/plugins/nvim/tips.zsh; tips "$PWD/{}"']]
vim.api.nvim_create_user_command("TipsPick", function() vim.fn.jobstart({ "bash", "-lc", tips_cmd }) end, {})
vim.keymap.set("n", "<leader>tp", function() vim.fn.jobstart({ "bash", "-lc", tips_cmd }) end, { desc = "Pick tips file (rofi)" })

-- -----------------------------------------------------------------------------
-- >> CUSTOM STATUSLINE WITH DIAGNOSTICS
-- This whole block is a self-contained feature.
-- It's complex enough that it probably deserves its own file eventually.
-- -----------------------------------------------------------------------------
local function get_diag_line_text(maxlen)
  local diags = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
  if #diags == 0 then return nil end
  table.sort(diags, function(a, b) return a.severity < b.severity end)
  local d = diags[1]
  local hl_map = { [1] = "DiagnosticError", [2] = "DiagnosticWarn", [3] = "DiagnosticInfo", [4] = "DiagnosticHint" }
  local msg = d.message:gsub("\n", " ")
  if vim.fn.strdisplaywidth(msg) > maxlen then msg = vim.fn.strcharpart(msg, 0, maxlen) .. "…" end
  return hl_map[d.severity], msg
end

function _G.diag_or_path()
  local hl, text = get_diag_line_text(80)
  if hl and text then return table.concat({ "%#", hl, "#", " ", text, " ", "%*" }) end
  return "%f"
end

function _G.diag_counts()
  -- Use a table where keys are the severity numbers themselves.
  -- vim.diagnostic.severity.ERROR is 1, WARN is 2, etc.
  local counts = {
    [vim.diagnostic.severity.ERROR] = 0,
    [vim.diagnostic.severity.WARN]  = 0,
    [vim.diagnostic.severity.INFO]  = 0,
    [vim.diagnostic.severity.HINT]  = 0,
  }

  -- This is a cleaner way to count. We use the diagnostic's severity
  -- number directly as the key to increment in our counts table.
  for _, diag in ipairs(vim.diagnostic.get(0)) do
    if counts[diag.severity] then
      counts[diag.severity] = counts[diag.severity] + 1
    end
  end

  local parts = {}
  -- Now, we build the output, making sure to include ALL levels.
  if counts[vim.diagnostic.severity.ERROR] > 0 then
    table.insert(parts, "E:" .. counts[vim.diagnostic.severity.ERROR])
  end
  if counts[vim.diagnostic.severity.WARN] > 0 then
    table.insert(parts, "W:" .. counts[vim.diagnostic.severity.WARN])
  end
  if counts[vim.diagnostic.severity.INFO] > 0 then
    table.insert(parts, "I:" .. counts[vim.diagnostic.severity.INFO])
  end
  if counts[vim.diagnostic.severity.HINT] > 0 then
    -- This was the missing part.
    table.insert(parts, "H:" .. counts[vim.diagnostic.severity.HINT])
  end

  return table.concat(parts, " ")
end

vim.o.statusline = "%{%v:lua.diag_or_path()%} %=%{%v:lua.diag_counts()%} %l:%c %p%%"
vim.api.nvim_create_autocmd({ "DiagnosticChanged", "CursorMoved" }, {
  callback = function() vim.cmd("redrawstatus") end,
})
