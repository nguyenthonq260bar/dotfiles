local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	position = "bottom",
	height = 20,
	color = colors.black,
	padding_right = 2,
	padding_left = 2,
	notch_offset = 0,
	shadow = true,
})
