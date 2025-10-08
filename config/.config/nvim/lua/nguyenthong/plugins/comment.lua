local setup, comment = pcall(require, "Comment")
if not setup then
	return
end
--gc + number + j or k
comment.setup()
