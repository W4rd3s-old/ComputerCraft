--By Wardes
shell.run("label set Grinder")
shell.run("clear")
print("Start enderfarm_grinder")

redstoneSide = "right"
mPort = 1
mModem = peripheral.find("modem")

while true do
  if mModem.isOpen(mPort) then
    event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    if message == "turnOnGrinder" then
      redstone.setOutput(redstoneSide, true)
      term.setTextColor (colors.green)
      print("Turn On grinder")
    elseif message == "turnOffGrinder" then
      redstone.setOutput(redstoneSide, false)
      term.setTextColor (colors.red)
      print("Turn Off grinder")
    elseif message == "reboot" then
      shell.run("reboot")
    end
  else
    mModem.open(mPort)
  end
end
