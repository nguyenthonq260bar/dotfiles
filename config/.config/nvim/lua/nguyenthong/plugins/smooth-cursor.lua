local status, cursor = pcall(require, "smear_cursor")

if not status then
	return
end

cursor.setup()
