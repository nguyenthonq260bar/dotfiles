local status, lualine = pcall(require, "lualine")

if not status then
  return
end

local mode_map = {
  ['NORMAL'] = 'N', --
  ['O-PENDING'] = 'N?',
  ['INSERT'] = 'I',
  ['VISUAL'] = 'V',
  ['V-BLOCK'] = 'VB',
  ['V-REPLACE'] = 'VR',
  ['REPLACE'] = 'R',
  ['COMMAND'] = 'C',
  ['SHELL'] = 'SH',
  ['TERMINAL'] = 'T',
  ['EX'] = 'X',
  ['S-BLOCK'] = 'SB',
  ['S-LINE'] = 'SL',
  ['SELECT'] = 'S',
  ['CONFIRM'] = 'Y?',
  ['MORE'] = 'M',
}
-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#ffffff',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#404040',
  green  = '#a5fc03',
  pink   = '#fa64e6',
  yellow = '#fff530',
  grey2  = '#353835',
}
local bubbles_theme = {
  normal = {
    a = { fg = colors.grey2, bg = colors.white , gui = 'bold'},
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },
  command = { a = {fg = colors.grey2, bg = colors.white , gui = 'bold'} },
  insert = { a = { fg = colors.grey2, bg = colors.yellow, gui = 'bold' } },
  visual = { a = { fg = colors.white, bg = colors.pink, gui = 'bold'} },
  replace = { a = { fg = colors.white, bg = colors.red , gui = 'bold' } },

  inactive = {
    a = { fg = colors.white, bg = colors.grey,   gui = 'bold' },
    b = { fg = colors.white, bg = colors.black,  gui = 'bold' },
    c = { fg = colors.white, bg = colors.grey2,  gui = 'bold' },
  },
}

lualine.setup({
  options = {
    theme = bubbles_theme,
    component_separators = {left = '', right = '', use_mode_colors = true },
    section_separators = {left = '', right = '' },
  },
  sections = {
    lualine_a = { { 'mode', separator = { right = '' }, right_padding = 2 , fmt = function(s) return mode_map[s] or s end } },
    lualine_b = {
      'branch',
      {'diff', symbols = {added = " 􀣝  " , modified = '~', removed = '􀢂  '} },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {'filetype'},
    lualine_z = {
      {

        'buffers',
        separator = { left = '' },
        left_padding = 2,
        symbols = {
          modified = ' 􀈌  ',
          alternate_file = ' 􁓔  ',
          directory =  '  ',
        },
        use_mode_colors = true,

      },
    },
  },

  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {},
})
