local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  return
end

telescope.setup({
    mappings = {
      i = {
        ["<Esc>"] = actions.close,  -- Đóng Telescope khi nhấn Esc
      }
    },
})

telescope.load_extension("fzf")
