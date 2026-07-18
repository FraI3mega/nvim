return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {

      win_options = {
        wrap = true,
      },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      autosave_changes = "unmodified",
      watch_for_changes = true,
    },
    -- Optional dependencies
    dependencies = {
      {
        "malewicz1337/oil-git.nvim",
        dependencies = { "stevearc/oil.nvim" },
      },
    },
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Oil" },
    },
  },
}
