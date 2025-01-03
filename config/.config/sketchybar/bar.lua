local colors = require("colors")

-- Equivalent to the --bar domain
-- sbar.bar({
--   height =20,
--   color = colors.transparent,
--   padding_right = 2,
--   padding_left = 2,
--   notch_offset = 6,
--   shadow = true,
--
-- })
--
sbar.bar({
  sticky = on,
  position= top ,
  height = 25,
  margin= 10,
  color = colors.transparent,
  border_color=colors.bar.border,
  border_width=0,
  padding_right=10,
  padding_left=10,
  corner_radius=8,
  blur_radius=12,
  y_offset=5
})
