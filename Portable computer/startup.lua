--By Wardes
shell.run("clear")
print("Initialization")

listApi = {
  {name = "mTestApi", code = "xWn6BtXA"}
}

if table.getn(listApi) ~= 0 then
  for i,v in ipairs(listApi) do
    mPath = fs.combine("rom/apis", v.name)
    shell.run("rm", v.name)
    shell.run("pastebin get ", v.code, v.name)
    shell.run("os.loadAPI(", v.name, ")")
    term.setTextColor (colors.blue)
    print("Api [" .. v.name .. "] loaded")
  end
  term.setTextColor (colors.green)
  print("All api loaded")
else
  term.setTextColor (colors.red)
  print("Not api found")
end
