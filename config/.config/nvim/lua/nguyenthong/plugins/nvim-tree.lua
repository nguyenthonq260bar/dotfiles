local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1



vim.cmd([[ highlight NvimTreeIndentMarker guifg=#ffffff]])
vim.cmd([[ highlight NvimTreeWinSeparator guifg=#ffffff guibg=None]])






vim.cmd([[ highlight VertSplit guifg=#ffffff guibg=#ff0000 ]])  -- Viền màu trắng, nền đỏ


nvimtree.setup({
  view = {
    float = {
      enable = false,
    },
    side = 'left',
  },
  renderer = {
    highlight_opened_files = "none",

    indent_markers = {
    enable = true,
    },
  },
})

