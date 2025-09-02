return {
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    opts = {
      direction = "float",
      open_mapping = [[<c-\>]],
      on_create = function(term)
        term:send("exec tmux")
      end,
    },
  }
}
-- vim: ts=2 sts=2 sw=2 et
