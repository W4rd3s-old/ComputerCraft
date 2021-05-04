--By Wardes
shell.run("label set Spawner")
shell.run("clear")
print("Start enderfarm_spawner")

redstoneSide = "top"
mPort = 1
mModem = peripheral.find("modem")

while true do
  if mModem.isOpen(mPort) then
    event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    if message == "turnOnSpawner" then
      redstone.setOutput(redstoneSide, true)
      term.setTextColor (colors.green)
      print("Turn On spawner")
    elseif message == "turnOffSpawner" then
      redstone.setOutput(redstoneSide, false)
      term.setTextColor (colors.red)
      print("Turn Off spawner")
    elseif message == "reboot" then
      shell.run("reboot")
    end
  else
    mModem.open(mPort)
  end
end
