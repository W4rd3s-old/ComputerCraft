--By Wardes
shell.run("label set EnderFarm")
os.loadAPI("button")
shell.run("clear")
print("Start enderfarm_main")

playerSensorSide = "left"
endermiteSensorSide = "right"
mPort = 1
mMonitor = peripheral.find("monitor")
mModem = peripheral.find("modem")
mRefined = peripheral.find("refinedstorage")


vPlayer = 0
vEndermite = 0

vSpawner = false

mModem.transmit(1,1, "turnOffSpawner")
mModem.transmit(1,1, "turnOffGrinder")

button.setMonitor(mMonitor)

spawnerButton = button.create("Spawner")
spawnerButton.setSize(9, 3)
spawnerButton.setPos(40, 4)
spawnerButton.onClick(function(ret) turnStateViaModem("Spawner",ret) end)

grinderButton = button.create("Grinder")
grinderButton.setSize(9, 3)
grinderButton.setPos(40, 9)
grinderButton.onClick(function(ret) turnStateViaModem("Grinder",ret) end)

autoButton = button.create("Auto")
autoButton.setSize(9, 3)
autoButton.setPos(40, 14)
autoButton.setDisable(true)
autoButton.onClick(function(val) print(val) end)

buttonTable = {spawnerButton, grinderButton, autoButton}

function turnStateViaModem(machine, state)
  if state then
    mModem.transmit(mPort,mPort, "turnOn"..machine)
  else
    mModem.transmit(mPort,mPort, "turnOff"..machine)
  end
end

function checkRedstone(side, editVar, x, y, name)
  mMonitor.setCursorPos(x,y)
  if redstone.getInput(side) then
    editVar = 1
    mMonitor.setTextColor(colors.green)
    mMonitor.write(name.." OK")
  else
    editVar = 0
    mMonitor.setTextColor(colors.red)
    mMonitor.write(name.." ERR")
  end
end

function updateScreen()
  mMonitor.clear()
  checkRedstone(playerSensorSide, vPlayer, 8, 1, "Player")
  checkRedstone(endermiteSensorSide, vEndermite, 31, 1, "Endermite")
end

function eventRedstone()
  os.pullEvent("redstone")
end

function eventModem()
  event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
end

function eventButton()
  button.await(buttonTable)
end

while true do
  if mModem.isOpen(mPort) then
    mMonitor.clear()
    updateScreen()
    parallel.waitForAny(eventRedstone, eventModem, eventButton)
    print("y")
  else
    mModem.open(mPort)
  end
  os.sleep(1)
end
