
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

treesitter.setup({
  modules = {},
  ignore_install = {},
  auto_install = true,
  sync_install = false,



  ensure_installed = { "lua", "python", "javascript" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },


})



