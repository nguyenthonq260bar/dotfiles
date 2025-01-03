local settings = require("settings")
local colors = require("colors")

local width = 15

local cal = sbar.add("item", {
  icon = {
    color = colors.white,
    padding_left = 8,
    padding_right = 21,
    font = {
      style = settings.font.style_map["Black"],
      size = 13.5,
    },
    y_offset = 0.5,
  },
  label = {
    color = colors.white,
    padding_right = 15,
    width = 49,
    align = "right",
    font = {
      size = 13.5,
      style = settings.font.style_map["Black"],
    },
  },
  position = "right",
  update_freq = 1,
  padding_left = 1,
  padding_right = 1,
  background = {
    color = colors.black,
    border_color = colors.white,
    border_width = 4,
    padding_left = 13,
    height = 30,

  },
})



sbar.add("item", { position = "right", width = width })

cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
  cal:set({ icon = os.date("%a - %d th %m"), label = os.date("%H:%M") })
end)




