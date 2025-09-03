return {
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    opts = {
      direction = "float",
      open_mapping = [[<c-\>]],
      on_create = function(term)
        local session_name = "_nvim_toggleterm_" .. vim.fn.getcwd() .. "_$(date +%s%4N)"
        term:send("exec tmux new-session -A -s " .. session_name)
        term:send("tmux set-option destroy-unattached")
        term:clear()
      end,
    },
  }
}
-- vim: ts=2 sts=2 sw=2 et
