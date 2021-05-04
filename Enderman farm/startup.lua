--By Wardes
shell.run("clear")
print("Start startup")

code = ""
fileName = "buffer"
if code ~= "" then
  if fs.exists(fileName) then
    shell.run("rm", fileName)
  end

  shell.run("pastebin get ", code, " buffer")
  shell.run("buffer")
else
  print("Code not found")
end
