--By Wardes
url = ""
mPath = "buffer"

if url ~= "" then
  local res = wget(url)
  if res then
    local file = fs.open( mPath, "w" )
    file.write(res)
    file.close()
    res.close()
    term.setTextColor (colors.green)
    print("Downloaded as " .. mPath)
    os.run(mPath)
  end
else
  term.setTextColor (colors.red)
  print("No url detected")
end
