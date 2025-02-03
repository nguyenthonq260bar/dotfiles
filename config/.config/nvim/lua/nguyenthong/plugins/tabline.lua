local status, tabby = pcall(require, "tabby")
if not status then
	return
end

local theme = {
	fill = "TabLineFill",
	head = "TabLine",
	current_tab = { fg = "#000000", bg = "#ffffff", style = "bold" },
	tab = "TabLine",
	win = "TabLine",
	tail = "TabLine",
	white = { bg = "#000000", fg = "#ffffff", style = "bold" },
}

tabby.setup({
	line = function(line)
		return {
			{
				{ "  ", hl = theme.white },
				line.sep("", theme.head, theme.fill),
			},
			line.tabs().foreach(function(tab)
				local hl = tab.is_current() and theme.current_tab or theme.tab
				return {
					line.sep("", hl, theme.fill),
					tab.is_current() and " " or " ",
					tab.number(),
					tab.name(),
					tab.close_btn(""),
					line.sep(" ", hl, theme.fill),
					hl = hl,
					margin = " ",
				}
			end),
			line.spacer(),
			-- line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
			-- 	return {
			-- 		line.sep("", theme.win, theme.fill),
			-- 		win.is_current() and " " or " ",
			-- 		win.buf_name(),
			-- 		line.sep("", theme.win, theme.fill),
			-- 		hl = theme.win,
			-- 		margin = " ",
			-- 	}
			-- end),

			{
				line.sep("", theme.tail, theme.fill),
				{ "  ", hl = theme.white },
			},
			hl = theme.fill,
		}
	end,
})
