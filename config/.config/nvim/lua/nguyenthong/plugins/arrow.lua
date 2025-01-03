local setup, arrow = pcall(require, "arrow")
if not setup then
  return
end

arrow.setup({
  show_icons = true,
  leader_key = "\t",
  buffer_leader_key = "m",
})
