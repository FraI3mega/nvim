return {
  { "max397574/better-escape.nvim", event = "VimEnter", opts = {} },
  {
    "https://codeberg.org/andyg/leap.nvim",
    lazy = false,
    config = function()
      -- See `:h leap-mappings`, `:h leap.visit-mappings` for more.

      -- Jump
      vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
      vim.keymap.set("n", "S", "<Plug>(leap-from-window)")

      -- Visit (jump - operate - jump back)
      vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-visit)")
      vim.keymap.set({ "x", "o" }, "ar", "<Plug>(leap-visit-text-object)")
      vim.keymap.set({ "x", "o" }, "ir", "<Plug>(leap-visit-inner-text-object)")

      vim.keymap.set("o", "rr", function() -- "visit line" shortcut
        return (vim.v.count == 0 and "1" or "") .. "<Plug>(leap-visit)"
      end, { expr = true })

      -- Automatic paste on return.
      vim.api.nvim_create_autocmd("User", {
        pattern = "VisitDone",
        group = vim.api.nvim_create_augroup("Visit", {}),
        callback = function(event)
          if (event.data.mode:match("^[vV\22]") or (vim.v.operator == "y")) and event.data.register == '"' then
            vim.cmd("normal! p")
          end
        end,
      })

      -- Treeselect
      vim.keymap.set({ "x", "o" }, "an", function()
        require("leap.treesitter").select({
          opts = require("leap.user").with_traversal_keys("n", "N"),
        })
      end)
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    -- Optional: See `:h nvim-surround.configuration` and `:h nvim-surround.setup` for details
    -- config = function()
    --     require("nvim-surround").setup({
    --         -- Put your configuration here
    --     })
    -- end
  },
  {
    "ankushbhagats/liveserver.nvim",
    event = { "BufReadPost", "BufNewFile" },
    build = "npm i",
    module = false,
    opts = {
      args = { -- accepts live-server cli arguments.
        port = 8080,
        ["no-browser"] = false,
        -- filetypes = "*", -- show lualine component for all files.
        -- ... add more ...
      },
    },
    config = true,
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    build = "./kitty/install-kittens.bash",
    event = "VeryLazy",
    keys = {
      {
        "<A-h>",
        function()
          require("smart-splits").resize_left()
        end,
      },
      {
        "<A-j>",
        function()
          require("smart-splits").resize_down()
        end,
      },
      {
        "<A-k>",
        function()
          require("smart-splits").resize_up()
        end,
      },
      {
        "<A-l>",
        function()
          require("smart-splits").resize_right()
        end,
      },
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
      },
      {
        "<C-\\>",
        function()
          require("smart-splits").move_cursor_previous()
        end,
      },
    },
  },
  { "wakatime/vim-wakatime", lazy = false },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
    },
    opts = {
      graph_style = vim.env.TERM == "xterm-kitty" and "kitty" or "unicode",
      disable_signs = true,
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...
    config = function()
      -- optional setup call to override plugin options
      -- alternatively you can set options with vim.g.grug_far = { ... }
      require("grug-far").setup({
        -- options, see Configuration section below
        -- there are no required options atm
      })
    end,
  },
  {
    "okuuva/auto-save.nvim",
    version = "^1.0.0", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      -- your config goes here
      -- or just leave it empty :)
      enabled = vim.env.KITTY_SCROLLBACK_NVIM ~= "true",
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")

        -- don't save for `sql` file types
        if utils.not_in(fn.getbufvar(buf, "&filetype"), { "oil" }) then
          return true
        end
        return false
      end,
    },
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
