-- plugins/transparent.lua

require("transparent").setup({
  enable = true,  -- Bật tính năng trong suốt
  extra_groups = {  -- Các nhóm highlight cần làm trong suốt
    "NormalFloat",    -- Các cửa sổ nổi
    "NvimTreeNormal", -- Cửa sổ NvimTree
    --"TelescopeNormal", -- Cửa sổ Telescope
  },
  exclude_groups = { -- Loại trừ các nhóm highlight nếu cần
    "StatusLine",     -- Ví dụ loại trừ StatusLine khỏi sự trong suốt
  }
})
