-- Better Escape (rewrite version, fixed)
local ok, better_escape = pcall(require, "better_escape")
if not ok then
	return
end

better_escape.setup({
	mappings = {
		i = {
			j = {
				k = function()
					vim.api.nvim_input("<Esc>")
					local current_line = vim.api.nvim_get_current_line()
					if current_line:match("^%s+$") then
						vim.schedule(function()
							vim.api.nvim_set_current_line("")
						end)
					end
				end,
			},
		},
	},
	timeout = 200,
})
